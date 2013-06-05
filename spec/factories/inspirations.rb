FactoryGirl.define do
  factory :inspiration do
  	description {Faker::Lorem.characters(1000)}
  	like 1
  	user 1
  	challenge 1

  	factory :invalid_inspiration do
  		description nil
  		like nil
  		user nil
  		challenge nil
  	end
  end
end
