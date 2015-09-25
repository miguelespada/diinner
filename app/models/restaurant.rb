class Restaurant
  include Mongoid::Document
  include Mongoid::Timestamps
  include RestaurantSearchable
  include PublicActivity::Common
  
  before_update :check_password_changed
  after_destroy :remove_activities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  def self.permitted_params
    [:name, :description, :password, :email, :phone, :address,
    :city_id, :latitude, :longitude, :photo, :contact_person]
  end

  devise :database_authenticatable,
          :rememberable, :trackable, :validatable

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

  field :has_changed_password, type: Boolean, default: false

  validates_presence_of :name
  validates_presence_of :email, :password, on: :create
  validates :name, uniqueness: true
  validates :email, uniqueness: true
  validates_length_of :password, minimum: 8, maximum: 16, on: :create

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

  has_many :menus, :dependent => :destroy
  has_many :tables, :dependent => :destroy
  has_many :payments, :dependent => :destroy
  has_attachment :photo, accept: [:jpg, :png, :gif]

  def can_be_deleted?
    self.reservations.count == 0
  end

  def reservations
    Reservation.in(table_id: tables.map{|table| table.id})
  end

  def customers
    reservations.map{ |reservation| reservation.user}.uniq
  end

  def evaluations
    reservations.map{|r| r.evaluation}.reject(&:nil?)
  end

  def is_customer? user
    customers.include?(user)
  end

  def notifications
    PublicActivity::Activity.where(recipient: self).desc(:created_at)
  end

  def has_tables?
    tables.count > 0
  end

  def has_menus?
    menus.count > 0
  end

  def menu_prices_left
    [ 20, 40, 60 ] - menus.map{|m| m.price}
  end

  def menus_full?
    menus.count == 3
  end

  def is_owned_by? user
    return true if self == user
  rescue
    false
  end

  def has_city?
    !city.nil?
  end

  def to_ionic_json
    {
        name: name,
        description: description,
        phone: phone,
        address: address,
        contact_person: contact_person,
        city: has_city? ? city.id.to_s : nil,
        photo: Cloudinary::Utils.cloudinary_url(photo.path)

    }
  end

  private

  def check_password_changed
    self.has_changed_password = true if self.encrypted_password_changed?
  end

end