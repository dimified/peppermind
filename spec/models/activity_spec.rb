require 'spec_helper'

describe Activity do
	before(:each) do
		@activity = create(:activity)
  end

	it "has a valid factory" do
	  expect(@activity).to be_valid
	end
end
