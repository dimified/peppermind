require 'spec_helper'

describe Inspiration do
	before(:each) do
		@inspiration = create(:inspiration)
  end

	it "has a valid factory" do
	  expect(@inspiration).to be_valid
	end

	it "is invalid when description is more than 1000 characters" do
		expect(build(:inspiration, description: Faker::Lorem.characters(1001))).to_not be_valid
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

  it "decrements like only if likes are 0 or above" do
    inspiration = build(:inspiration, like: 0)
    inspiration.remove_like
    expect(inspiration.like).to eq(0)
  end
end
