class Inspiration
  include Mongoid::Document

  # Fields
  field :description, type: String

  # Associations
  has_many :likes
  belongs_to :user
  belongs_to :challenge

  # Validations
  validates :description, presence: true, length: {maximum: 255}
end
