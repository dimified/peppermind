require 'spec_helper'

describe User do
	before(:each) do
		@user = create(:user)
	end

	it "has a valid factory" do
	  expect(@user).to be_valid
	end

	it "is invalid with a duplicate email address" do
		expect(build(:user, email: @user.email)).to_not be_valid
	end

	it "is invalid with a duplicate display name" do
		expect(build(:user, email: @user.display_name)).to_not be_valid
	end

	it "is invalid when password is less than 8 characters" do
		expect(build(:user, password: "gravity")).to_not be_valid
	end
end