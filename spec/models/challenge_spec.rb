require 'spec_helper'

describe Challenge do
  before(:each) do
		@challenge = create(:challenge)
	end

	it "has a valid factory" do
	  expect(@challenge).to be_valid
	end

	it "is invalid when title is more than 100 characters" do
		expect(build(:challenge, question: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean ma")).to_not be_valid
	end

	it "is invalid when description is more than 255 characters" do
		expect(build(:challenge, description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,q")).to_not be_valid
	end

	it "converts duration into duration_string" do 
		challenge = create(:challenge)
		@controller = ApplicationController.new
		expect(@controller.send(:convert_date, challenge.duration)).to eq("05.06.2013")
	end
end