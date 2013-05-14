class Idea
  include Mongoid::Document
  include Mongoid::Timestamps

  # Associations
  belongs_to :user

  # Fields
  field :question, type: String
  field :description, type: String
  field :duration, type: String

  # Validations
  validates :question, presence: true, length: {maximum: 100}
  validates :description, presence: true
  validates :duration, presence: true

  # Number of Elements per Page
  paginates_per 10
end
