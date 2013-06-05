FactoryGirl.define do
  factory :challenge do
  	question {Faker::Lorem.characters(100)}
  	description {Faker::Lorem.characters(1000)}
    duration Date.new(2100, 06, 05)
  	duration_string "05.06.2100"
    status :open
    user 1
    dito 1

    factory :invalid_challenge do
			question nil
			description nil
			duration nil
      status nil
      user nil
      dito nil
		end
  end
end