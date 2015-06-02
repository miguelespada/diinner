class Restaurant
  include Mongoid::Document
  include Mongoid::Timestamps
  include RestaurantSearchable
  include PublicActivity::Common

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  def self.permitted_params
    [:name, :description, :password, :email, :phone, :address,
    :city_id, :latitude, :longitude, :photo, :contact_person]
  end

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :name,              type: String, default: ""
  field :description,       type: String, default: ""
  field :phone,             type: String, default: ""
  field :address,           type: String, default: ""
  field :contact_person,     type: String
  belongs_to :city

  field :latitude,          type: String, default: "40.550344000000000000"
  field :longitude,         type: String, default: "-1.651008000000047000"

  has_many :menus
  has_many :tables
  has_many :payments
  has_attachment :photo, accept: [:jpg, :png, :gif]

  def reservations
    Reservation.in(table_id: tables.map{|table| table.id})
  end

  def customers
    reservations.map{ |reservation| reservation.user}.uniq
  end

  def is_customer? user
    customers.include?(user)
  end

  def has_menus?
    menus.count > 0
  end

  def has_tables?
    tables.count > 0
  end

  def notifications
    PublicActivity::Activity.where(recipient: self).desc(:created_at)
  end

  def is_owned_by?(restaurant)
    restaurant == self
  rescue
    false
  end
end