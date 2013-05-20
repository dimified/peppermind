class Inspiration
  include Mongoid::Document
  embedded_in :challenge

  # Fields
  field :description, type: String

  # Associations
  has_many :likes

  # Validations
  validates :description, presence: true, length: {maximum: 255}
end
