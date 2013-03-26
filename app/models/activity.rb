class Activity
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :user
  belongs_to :trackable, polymorphic: true

  # Fields
  field :action, type: String
  field :trackable_type, type: String

  # Accessible Attributes
  attr_accessible :action, :trackable

  # Number of Elements per Page
  paginates_per 10
end
