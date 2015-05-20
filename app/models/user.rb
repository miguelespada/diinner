class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable
  include Loggeable
  include Notificable
  include Mongoid::Enum

  # TODO add sexual orientation
  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
  field :birth, type: Date
  enum :gender, [:male, :female, :undefined]
  has_many :test_completed, class_name: "TestResponse"
  has_many :reservations

  def first_login?
    updated_at == created_at
  end

  def opposite_sex
    return :female if gender == :male
    return :male if gender == :female
    return :none
  end

  def is_owned_by?(user)
    user == self
  rescue
    false
  end

  def test_pending
    Test.not_in(id: test_completed.map{|m| m.test.id}, gender: opposite_sex)
  end
end