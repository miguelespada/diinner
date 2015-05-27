class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable
  include Loggeable
  include Notificable
  include Mongoid::Enum

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
  field :birth, type: Date
  enum :gender, [:male, :female]
  field :customer, type: String
  field :stripe_default_card, type: String

  has_many :test_completed, class_name: "TestResponse"
  has_many :reservations

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

  def test_pending
    Test.not_in(id: test_completed.map{|m| m.test.id}, gender: opposite_sex)
  end

  def update_customer_information! token
    self.customer = Stripe::Customer.create(
      :source => token,
      :description => name
    ).id
    self.save!
  end

  def retrieve_card_from_stripe
    if !customer.nil?
      c = Stripe::Customer.retrieve(customer)
      card = c.sources.retrieve(c.default_source)
      self.stripe_default_card = card.last4
      self.save!
    end
  end

  def default_card
    retrieve_card_from_stripe if stripe_default_card.nil?
    stripe_default_card
  end
end