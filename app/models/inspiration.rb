class Inspiration
  include Mongoid::Document
  embedded_in :ideas

  # Fields
  field :description, type: String

  # Validations
  validates :description, presence: true, length: {maximum: 255}
end
