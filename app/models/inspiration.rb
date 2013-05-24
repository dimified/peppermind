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

  def add_like
    self.like += 1
    self.save
  end

  def remove_like
    self.like -= 1
    self.save
  end
end
