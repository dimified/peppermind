require 'spec_helper'

describe Socialprovider do
	before(:each) do
		@user = create(:user)
	end

  it "has a valid factory" do
  	expect(create(:socialprovider, 
  		user_id: @user.id, 
  		display_name: @user.display_name,
  		email: @user.email)).to be_valid
  end
end