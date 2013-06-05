require 'spec_helper'

describe Socialprovider do
	before(:each) do
		@socialprovider = create(:socialprovider)
	end

  it "has a valid factory" do
  	expect(@socialprovider).to be_valid
  end
end
