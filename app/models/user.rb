class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable
  include Mongoid::Enum
  include PublicActivity::Model
  tracked

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
  delegate :max_age, :min_age, :city, :to => :preference, :allow_nil => true

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

  def update_customer_information! token
    stripe_customer = Stripe::Customer.create(
      :source => token,
      :description => name
    )
    self.customer = stripe_customer.id
    set_default_card stripe_customer
    self.save!
  end

  def set_default_card stripe_customer
    self.stripe_default_card = stripe_customer.sources.retrieve(stripe_customer.default_source).last4
  end

  def retrieve_card_from_stripe
    if !customer.nil?
      set_default_card Stripe::Customer.retrieve(customer)
      self.save!
    end
  end

  def default_card
    retrieve_card_from_stripe if !has_default_card?
    stripe_default_card
  end

  def has_default_card?
    !stripe_default_card.nil?
  end

end