 class Challenge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  before_validation :validate_date

  # Associations
  belongs_to :user
  has_many :ditos
  has_many :inspirations

  # Fields
  field :question, type: String
  field :description, type: String
  field :duration, type: Date
  field :dito, type: Integer, default: 0
  field :status, type: Symbol

  # Formatted date string
  attr_accessor :duration_string, :status

  # Validations
  validates :question, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 255 }

  # Number of Elements per Page
  paginates_per 10

  def add_dito
    self.dito += 1
    self.save
  end

  def remove_dito
    if self.dito > 0
      self.dito -= 1
    else
      self.dito = 0
    end
    self.save
  end

  def self.is_over
    self.all.each do |challenge|
      if Time.now >= challenge.duration
        puts "#{Time.now}: Time is over for challenge (#{challenge.duration.to_s})"

        # Change status of Challenge to :closed
        challenge.status = :closed
        challenge.save
        puts "Challenge status updated: [id: #{challenge.id}, status: #{challenge.status}]"

        # Add points to the users of the first three most liked inspirations
        challenge.inspirations.desc(:like).limit(3).each do |top|
          points = top.like * 5
          top.user.increment(points: points)
          puts "User #{top.user.id} gets #{points} Points for the inspiration #{top.id}"
        end
      else
        puts "#{Time.now}: Time is NOT over for challenge: [id: #{challenge.id}, status: #{challenge.status}, time: #{challenge.duration.to_date}]"
      end
    end
  end

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
