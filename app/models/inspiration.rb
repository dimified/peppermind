class Inspiration
  include Mongoid::Document

  # Fields
  field :description, type: String
  field :like, type: Integer, default: 0

  # Associations
  has_many :likes
  belongs_to :user
  belongs_to :challenge

  # Validations
  validates :description, presence: true, length: {maximum: 255}
  validates :like, numericality: true, allow_nil: false
end
