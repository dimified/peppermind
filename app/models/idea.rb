class Idea
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Fields
  field :title, type: String
  field :description, type: String
  field :problem, type: String
  field :solution, type: String

  ## Validations
  validates :title, presence: true, length: {maximum: 40}
  validates :description, presence: true, length: {maximum: 255}

  ## Associations
  belongs_to :user
end
