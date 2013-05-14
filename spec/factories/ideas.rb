# spec/factories/challenges.rb

FactoryGirl.define do
  factory :challenge do
  	question {Faker::Lorem.characters(100)}
  	description {Faker::Lorem.characters(255)}
    user

    factory :invalid_challenge do
			question nil
			description nil
		end
  end
end