FactoryGirl.define do
  factory :challenge do
  	question {Faker::Lorem.characters(100)}
  	description {Faker::Lorem.characters(255)}
  	duration_string "05.06.2013"
    user 1

    factory :invalid_challenge do
			question nil
			description nil
			duration nil
		end
  end
end