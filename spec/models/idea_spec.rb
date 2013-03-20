require 'spec_helper'

describe Idea do
  before(:each) do
		@idea = create(:idea)
	end

	it "has a valid factory" do
	  expect(@idea).to be_valid
	end

	it "is invalid when title is more than 40 characters" do
		expect(build(:idea, title: "Lorem ipsum dolor sit amet, consectetuer!")).to_not be_valid
	end

	it "is invalid when summary is more than 255 characters" do
		expect(build(:idea, summary: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor i")).to_not be_valid
	end
end