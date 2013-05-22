FactoryGirl.define do
  factory :inspiration do
  	description {Faker::Lorem.characters(255)}
  	like 1
  	user
  	challenge

  	factory :invalid_inspiration do
  		description nil
  		like nil
  		user nil
  		challenge nil
  	end
  end
end
