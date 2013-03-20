# spec/factories/ideas.rb

FactoryGirl.define do
  factory :idea do
  	title {Faker::Lorem.characters(40)}
  	description {Faker::Lorem.characters(255)}
  	problem {Faker::Lorem.characters(1000)}
  	solution {Faker::Lorem.characters(1000)}
    user

    factory :invalid_idea do
			title nil
			description nil
			problem nil
			solution nil
		end
  end
end