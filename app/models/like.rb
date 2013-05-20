class Like
  include Mongoid::Document

  # Associations
  belongs_to :user
  belongs_to :inspiration
end
