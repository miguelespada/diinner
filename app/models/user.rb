class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable
  include Mongoid::Enum
  include PublicActivity::Common
  after_destroy :remove_activities

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
  field :birth, type: Date
  enum :gender, [:male, :female]
  field :customer, type: String
  field :stripe_default_card, type: String
  field :dropped_out, type: Boolean, default: false

  field :test_profile, :type => Hash 

  field :notifications_read_at, type: DateTime

  has_many :test_completed, class_name: "TestResponse"
  has_many :reservations

  has_one :preference
  accepts_nested_attributes_for :preference
  delegate :max_age, :min_age, :city, :menu_range, :after_plan, :to => :preference, :allow_nil => true

  validates :birth, presence: {message: 'Debes modificar tu fecha de nacimiento'}, on: :update, date: {after: Proc.new { Time.now - 100.year}, before: Proc.new { Time.now - 18.year}}


  def self.birth_date_first
    118.years.ago
  end

  def self.birth_date_last
    18.years.ago
  end

  # CACHE CONTROL
  def cached_future_reservations
    # Rails.cache.fetch("future_reservations_" + self.id.to_s, expires_in: 1.day) do 
      reservations.includes(:table).where(cancelled: false, :date.gte => Date.today).asc('date').to_a.select{|r| r.table.processed or r.date > Date.today}
    # end
  end

  def cached_to_evaluate_reservations
    # Rails.cache.fetch("to_evaluate_reservations_" + self.id.to_s, expires_in: 1.day) do 
      reservations.includes(:table).where(paid: true, :date.lte => Date.today).asc('date').select{|r| r.can_be_evaluated?}
    # end
  end

  def has_reservations?
    # Rails.cache.fetch("has_reservations_" + self.id.to_s, expires_in: 1.day) do 
      reservations.count > 0
    # end
  end

  def cached_test_completed
    # Rails.cache.fetch("test_completed_" + id.to_s, expires_in: 1.day) do 
      test_completed.to_a.map{|m| m.test_id if !m.skipped?}.compact
    # end
  end

  def flush_cache
    # Rails.cache.delete("future_reservations_" + self.id.to_s)
    # Rails.cache.delete("to_evaluate_reservations_" + self.id.to_s)
    # Rails.cache.delete("has_reservations_" + self.id.to_s)
    # Rails.cache.delete("notifications_" + self.id.to_s)
  end

  def future_reservations
    reservations.includes(:table).where(cancelled: false, :date.gte => Date.today).asc('date').to_a.select{|r| r.table.processed or r.date > Date.today}
  end

  def to_evaluate_reservations
    reservations.includes(:table).where(paid: true, :date.lte => Date.today).asc('date').select{|r| r.can_be_evaluated?}
  end

  def has_reservations?
    reservations.count > 0
  end

  def test_completed_unskipped
    test_completed.to_a.map{|m| m.test_id unless m.skipped?}.compact
  end

  def test_skipped
    test_completed.to_a.map{|m| m.test_id if m.skipped?}.compact
  end

  def drop_out
    self.dropped_out = true
    self.birth = nil
    self.gender = :male
    preference.destroy
  end

  def drop_in
    self.dropped_out = false
  end

  def first_login?
    (updated_at == created_at) or self.dropped_out
  end

  def opposite_sex
    gender == :male ? :female : :male
  end

  def is_owned_by?(user)
    user == self
  rescue
    false
  end

  def has_preferences?
    !preference.nil? and preference.respond_to? :to_ionic_json
  end

  def test_pending
    Test.gender_tests(self.gender) - test_completed.to_a.map{|m| m.test_id }.compact
  end

  def sample_test
    Test.find(test_pending.sample.to_s) unless test_pending.empty?
  end

  def update_customer_information! reservation
    self.customer = reservation.customer
    self.stripe_default_card = reservation.stripe_default_card
    self.save!
  rescue
    false
  end

  def get_stripe_default_card! stripe_customer
    stripe_customer.sources.retrieve(stripe_customer.default_source).last4
  end

  def retrieve_card_from_stripe
    if !customer.nil?
      set_default_card Stripe::Customer.retrieve(customer)
      self.save!
    end
  end

  def retrieve_card_token
    if !customer.nil?
      Stripe::Customer.retrieve(customer).sources.data[0].id
    end
  end

  def default_card
    retrieve_card_from_stripe if !has_default_card?
    stripe_default_card
  end

  def has_default_card?
    !stripe_default_card.nil?
  end

  def notifications
    PublicActivity::Activity.where(recipient: self).desc(:created_at).limit(10)
  end

  def read_notifications
    self.update(notifications_read_at: DateTime.now)
  end

  def to_ionic_json
    {
      name: name,
      email: email,
      birth: birth,
      image_url: image_url,
      notifications_read_at: notifications_read_at,
      gender: gender,
      payment: {
          has_default_card: has_default_card?,
          default_card: default_card
      },
      preference: has_preferences? ? preference.to_ionic_json : nil,
      first_login: first_login?
    }
  end

  def age
    now = Date.today
    now.year - birth.year - ((now.month > birth.month || (now.month == birth.month && now.day >= birth.day)) ? 0 : 1)
    rescue
      30
  end

  def matches_age_preference? other
    other.age <= max_age && other.age >= min_age
  rescue
    true
  end


  def profile criteria
    generate_test_profile if test_profile.nil? 
    return 1 if test_completed_unskipped.count == 0
    test_profile[criteria] / test_completed_unskipped.count.to_f
  end

  def generate_test_profile
    self.test_profile =  { :expectativas => 0, :cultura => 0, 
                    :foodie => 0, :frikismo => 0,
                    :estudios => 0, :belleza => 0, :humor => 0}


    test_completed.includes(:test).to_a.each do |response|
      process_new_test_response response
    end
  end 

  def process_new_test_response response
    
    self.test_profile = { :expectativas => 0, :cultura => 0, 
                    :foodie => 0, :frikismo => 0,
                    :estudios => 0, :belleza => 0, :humor => 0} if self.test_profile.nil?
    
    if !response.skipped?
      factor = response.response_is_a? ? 1 : -1
      self.test_profile[:expectativas] += ((response.expectativas || 0) * factor)
      self.test_profile[:cultura] += ((response.cultura || 0) * factor)
      self.test_profile[:foodie] += ((response.foodie || 0) * factor)
      self.test_profile[:frikismo] += ((response.frikismo || 0) * factor)
      self.test_profile[:estudios] += ((response.estudios || 0) * factor)
      self.test_profile[:belleza] += ((response.belleza || 0) * factor)
      self.test_profile[:humor] += ((response.humor || 0) * factor)
    end

    self.save!
  end


  def affinity other
    a = (
      (profile(:expectativas) - other.profile(:expectativas)).abs +
      (profile(:cultura) - other.profile(:cultura)).abs + 
      (profile(:foodie) - other.profile(:foodie)).abs +
      (profile(:frikismo) - other.profile(:frikismo)).abs +
      (profile(:estudios) - other.profile(:estudios)).abs +
      (profile(:belleza) - other.profile(:belleza)).abs +
      (profile(:humor) - other.profile(:humor)).abs
    ) / 7.0

    # NOTE: we normalize the value 1 (highiest) - 0 (lowest)
    1.0 - a
  end

  def busy? date
    reservations.where(date: date).each do |r|
      return true if !r.cancelled?
    end
    false
  end

  def suggestions
    return [] if !has_preferences?
    params = {price: menu_range, city: city, after_plan: after_plan, date: Date.tomorrow.strftime("%d/%m/%Y"), companies_attributes: []}
    suggestionEngine = SuggestionEngine.new self, params
    suggestionEngine.search.first(3) 
  end

  def has_notifications?
    notifications and notifications.length > 0
  end

  def has_unread_notifications?
    PublicActivity::Activity.where(recipient: self, :created_at.gte => notifications_read_at).count > 0
  end
end