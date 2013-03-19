class Idea
  include Mongoid::Document

  ## Fields
  field :title
  field :summary
  field :problem
  field :solution

  ## Validations
  validates :title, presence: true
  validates :summary, presence: true
end
