class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :socialproviders, dependent: :destroy
  has_many :activities
  has_many :ditos
  has_many :likes
  has_many :inspirations
  has_many :challenges

  # Database authenticatable
  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''

  # Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  # Rememberable
  field :remember_created_at, type: Time

  # Trackable
  field :sign_in_count,      type: Integer, :default => 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  # Custom Fields
  field :display_name, type: String
  field :points, type: Integer, default: 0
  field :level, type: Symbol, default: :rookie

  # Validations
  validates :email, confirmation: true, uniqueness: true
  validates :display_name, presence: true, uniqueness: true

  # Attributes accessible
  attr_accessible :login, :display_name, :email, :email_confirmation, :password, :points

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'display_name'
  attr_accessor :login, :email_confirmation

  # Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  # Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  # Token authenticatable
  # field :authentication_token, :type => String

  # function to manage user's login via email or display_name
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login).downcase
      where(conditions).where('$or' => [ { display_name: /^#{ Regexp.escape(login) }$/i }, { email: /^#{ Regexp.escape(login) }$/i } ]).first
    else
      where(conditions).first
    end
  end

  def validate_display_name(name)
    if name.blank?
      errors.add(:display_name, I18n.t('account.validation.display_name.blank'))
    end

    if User.where(display_name: name).exists?
      errors.add(:display_name, I18n.t('account.validation.display_name.not_unique'))
    end
  end

  def increment(options = {})
    inc = self.points
    inc += options[:points] || 1
    update_attributes(points: inc)
  end

  def decrement(options = {})
    dec = self.points
    dec -= options[:points] || 1
    update_attributes(points: dec)
  end
end
