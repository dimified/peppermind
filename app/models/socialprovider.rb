class Socialprovider
  include Mongoid::Document

  # Associations
  belongs_to :user

  # Fields
  field :user_id, type: Integer
  field :display_name, type: String
  field :email, type: String
  field :uid, type: String
  field :provider, type: String

  # Accessible Attributes
  attr_accessible :display_name, :email, :uid, :provider
end
