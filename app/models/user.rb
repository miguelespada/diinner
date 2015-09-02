class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable
  include Mongoid::Enum
  include PublicActivity::Common

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
  field :birth, type: Date
  enum :gender, [:male, :female]
  field :customer, type: String
  field :stripe_default_card, type: String

  has_many :test_completed, class_name: "TestResponse"
  has_many :reservations

  has_one :preference
  accepts_nested_attributes_for :preference
  delegate :max_age, :min_age, :city, :menu_price, :to => :preference, :allow_nil => true

  def first_login?
    updated_at == created_at
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
    !preference.nil?
  end

  def test_pending
    Test.not_in(id: test_completed.map{|m| m.test.id}, gender: opposite_sex)
  end

  def get_stripe_create_customer! token
    Stripe::Customer.create(
      :source => token,
      :description => name
    )
    # TODO test sth is wrong
  end

  def update_customer_information! token
    stripe_customer = get_stripe_create_customer!(token)
    self.customer = stripe_customer.id
    self.stripe_default_card = get_stripe_default_card!(stripe_customer)
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
    PublicActivity::Activity.where(recipient: self).desc(:created_at)
  end

  def notify_pending_reservation reservation
    self.create_activity key: "reservation.pending", owner: reservation.restaurant, recipient: self
  end

  def to_ionic_json
    {
      name: self.name,
      email: self.email,
      birth: self.birth,
      image_url: self.image_url,
      gender: self.gender,
      payment: {
          has_default_card: has_default_card?,
          default_card: default_card
      },
      preference: self.preference ? self.preference.to_ionic_json : nil
    }
  end

  def age
     now = Date.today
     now.year - birth.year - ((now.month > birth.month || (now.month == birth.month && now.day >= birth.day)) ? 0 : 1)
  end

  def matches_age_preference? other
    other.age <= max_age && other.age >= min_age
  rescue
    true
  end

end