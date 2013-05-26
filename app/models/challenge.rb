 class Challenge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  before_validation :validate_date
  after_create :init

  # Associations
  belongs_to :user
  has_many :ditos
  has_many :inspirations

  # Fields
  field :question, type: String
  field :description, type: String
  field :duration, type: Date
  field :dito, type: Integer, default: 0
  field :status, type: Symbol, default: :open

  # Formatted date string
  attr_accessor :duration_string

  # Fields accessable by the user
  attr_accessible :question, :description, :duration_string

  # Validations
  validates :question, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 255 }

  # Number of Elements per Page
  paginates_per 10

  def init
    self.status = :open
    self.save
  end

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

  def self.rewards
    # challenges may not exist
    if self.empty?
      puts "#{Time.now}: No Challenges exist"
    else
      self.all.each do |challenge|

        # only open challenges are relevant which are over or within actual time
        if Time.now >= challenge.duration && challenge.status == :open
          puts "#{Time.now}: Time is over for challenge (#{challenge.duration})"

          # inspirations may not exist
          unless challenge.inspirations.empty?

            # add points to the users of the first three most liked inspirations
            challenge.inspirations.desc(:like).limit(3).each do |top|
              points = top.like * 5
              top.user.add_points(points: points)
              puts "User #{top.user.id} gets #{points} Points for the inspiration #{top.id}"
            end

            # change status of Challenge to :closed
            challenge.status = :closed

          # if so the due date will be extended
          else
            challenge.duration += 14.days
          end

          # result statement
          challenge.save
          puts "Challenge status updated: [id: #{challenge.id}, status: #{challenge.status}, time: #{challenge.duration}]"

        else
          if challenge.status == :open
            puts "#{Time.now}: [OPEN] Still open challenge: [id: #{challenge.id}, status: #{challenge.status}, time: #{challenge.duration}]"
          # elsif challenge.status == :closed
          #   puts "#{Time.now}: [CLOSED] Already closed challenge: [id: #{challenge.id}, status: #{challenge.status}, time: #{challenge.duration.to_date}]"
          end
        end
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
