# spec/factories/ideas.rb

FactoryGirl.define do
  factory :idea do
  	title {Faker::Lorem.characters(40)}
  	summary {Faker::Lorem.characters(255)}
  	problem {Faker::Lorem.characters(1000)}
  	solution {Faker::Lorem.characters(1000)}

    factory :invalid_idea do
			title nil
			summary nil
			problem nil
			solution nil
		end
  end
end