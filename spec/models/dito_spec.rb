require 'spec_helper'

describe Dito do
	it "has a valid factory" do
		dito = create(:dito)
	  expect(dito).to be_valid
	end
end
