require 'spec_helper'

describe Dito do
	before(:each) do
		@dito = create(:dito)
  end

	it "has a valid factory" do
	  expect(@dito).to be_valid
	end
end
