class Dito
  include Mongoid::Document

  # Associations
  belongs_to :user
  belongs_to :challenge
end
