require 'spec_helper'

describe Like do
	before(:each) do
		@like = create(:like)
  end

	it "has a valid factory" do
	  expect(@like).to be_valid
	end
end
