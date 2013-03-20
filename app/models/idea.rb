class Idea
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Fields
  field :title
  field :summary
  field :problem
  field :solution

  ## Validations
  validates :title, presence: true, length: {maximum: 40}
  validates :summary, presence: true, length: {maximum: 255}

  ## Associations
  belongs_to :user
end
