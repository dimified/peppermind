class Inspiration
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  # Fields
  field :description, type: String
  field :like, type: Integer, default: 0

  # Associations
  has_many :likes
  belongs_to :user
  belongs_to :challenge

  # Validations
  validates :description, presence: true, length: { maximum: 1000 }
  validates :like, numericality: true, allow_nil: false

  def add_like
    self.like += 1
    self.save
  end

  def remove_like
    if self.like > 0
      self.like -= 1
    else
      self.like = 0
    end
    self.save
  end
end
