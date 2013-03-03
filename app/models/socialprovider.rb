class Socialprovider
  include Mongoid::Document
  field :user_id, type: Integer
  field :display_name, type: String
  field :email, type: String
  field :uid, type: String
  field :provider, type: String

  belongs_to :user
  attr_accessible :display_name, :email, :uid, :provider
end
