require 'spec_helper'

describe Inspiration do
	before(:each) do
		@inspiration = create(:inspiration)
  end

	it "has a valid factory" do
	  expect(@inspiration).to be_valid
	end

	it "is invalid when description is more than 255 characters" do
		expect(build(:inspiration, description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,q")).to_not be_valid
	end

 	it "is invalid when like is nil" do
    expect(build(:inspiration, like: nil)).to_not be_valid
	end

	it "increments like" do
    expect {
      @inspiration.add_like
    }.to change(@inspiration, :like).by(1)
  end

  it "decrements like" do
    expect {
      @inspiration.remove_like
    }.to change(@inspiration, :like).by(-1)
  end
end
