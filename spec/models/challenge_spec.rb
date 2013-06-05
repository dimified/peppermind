require 'spec_helper'

describe Challenge do
	it "has a valid factory" do
		challenge = create(:challenge)
	  expect(challenge).to be_valid
	end

	it "is invalid when title is more than 100 characters" do
		expect(build(:challenge, question: Faker::Lorem.characters(101))).to_not be_valid
	end

	it "is invalid when description is more than 1000 characters" do
		expect(build(:challenge, description: Faker::Lorem.characters(1001))).to_not be_valid
	end

	it "converts duration into duration_string" do 
		challenge = create(:challenge)
		@controller = ApplicationController.new
		expect(@controller.send(:convert_date, challenge.duration)).to eq("05.06.2100")
	end

	it "increments dito" do
		challenge = create(:challenge)
    expect {
      challenge.add_dito
    }.to change(challenge, :dito).by(1)
  end

  it "decrements dito" do
  	challenge = create(:challenge)
    expect {
      challenge.remove_dito
    }.to change(challenge, :dito).by(-1)
  end

  it "decrements dito only if ditos are 0 or above" do
    challenge = create(:challenge)
    challenge.remove_dito
    expect(challenge.dito).to eq(0)
  end
end
