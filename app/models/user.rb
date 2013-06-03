class User
  include Mongoid::Document
  after_create :init
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

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
  attr_accessible :login, :display_name, :email, :email_confirmation, :password

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'display_name'
  attr_accessor :login, :email_confirmation

  # Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String

  index({ confirmation_token: 1 }, { unique: true, name: 'confirmation_token_index' })

  # Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  # Token authenticatable
  # field :authentication_token, :type => String

  def init
    self.level = :rookie
    self.save
  end

  # function to manage user's login via email or display_name
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login).downcase
      where(conditions).where('$or' => [ { display_name: /^#{ Regexp.escape(login) }$/i }, { email: /^#{ Regexp.escape(login) }$/i } ]).first
    else
      where(conditions).first
    end
  end

  # confirm registration
  def password_required?
    super if confirmed?
  end

  # validations
  def password_match?(password, confirm)
    if password.blank?
      errors.add(:password, I18n.t('devise.confirmations.show.error.blank'))
    end

    if confirm.blank?
      errors.add(:password_confirmation, I18n.t('devise.confirmations.show.error.confirmation_blank'))
    end

    if password != confirm
      errors.add(:password_confirmation, I18n.t('devise.confirmations.show.error.confirmation'))
    end

    password == confirm && !password.blank?
  end

  def validate_display_name(name)
    if name.blank?
      errors.add(:display_name, I18n.t('account.validation.display_name.blank'))
    end

    if User.where(display_name: name).exists?
      errors.add(:display_name, I18n.t('account.validation.display_name.not_unique'))
    end
  end

  def validate_email(email, confirm)
    unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
      errors.add(:email, I18n.t('account.validation.email.format'))
    end

    unless confirm === email
      errors.add(:email, I18n.t('account.validation.email.confirm'))
    end

    if User.where(email: email).exists?
      errors.add(:email_confirm, I18n.t('account.validation.email.not_unique'))
    end
  end

  # user ranking
  def add_points(options = {})
    self.points += options[:points] || 1
    self.save
  end

  def remove_points(options = {})
    points = options[:points] || 1

    if self.points <= 0
      self.points = 0
    elsif self.points < points
      self.points -= self.points
    else
      self.points -= points
    end
    self.save
  end

  def update_user_level
    points = self.points
    level = self.level

    case
      # Rookie
      when 0 <= points && points <= 99
        unless level == :rookie
          self.level = :rookie
        end
      # Seeker
      when 100 <= points && points <= 199
        unless level == :seeker
          self.level = :seeker
        end
      # Inspirer
      when 200 <= points && points <= 299
        unless level == :inspirer
          self.level = :inspirer
        end
      # Solver
      when 300 <= points
        unless level == :solver
          self.level = :solver
        end
    end
    self.save
  end
end

