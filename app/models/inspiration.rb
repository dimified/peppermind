class Inspiration
  include Mongoid::Document
  embedded_in :challenges

  # Fields
  field :description, type: String

  # Validations
  validates :description, presence: true, length: {maximum: 255}
end
