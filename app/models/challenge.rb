 class Challenge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  before_validation :validate_date

  # Associations
  belongs_to :user
  has_many :ditos
  has_many :inspirations

  # Formatted date string
  attr_accessor :duration_string

  # Fields
  field :question, type: String
  field :description, type: String
  field :duration, type: Date

  # Validations
  validates :question, presence: true, length: { maximum: 100 }
  validates :description, presence: true

  # Number of Elements per Page
  paginates_per 10

  private

  # convert date string in Date object and validates date
  def validate_date
    if self.duration.nil?
      if self.duration_string.match(/^\d{2}\.\d{2}\.\d{4}$/)
        self.duration = Date.strptime self.duration_string, '%d.%m.%Y'

        unless self.duration > DateTime.now.to_date
          errors.add(:duration_string, I18n.t('mongoid.errors.models.challenge.attributes.duration_string.not_in_future'))
        end
      else
        errors.add(:duration_string, I18n.t('mongoid.errors.models.challenge.attributes.duration_string.invalid'))
      end
    end
  end
end
