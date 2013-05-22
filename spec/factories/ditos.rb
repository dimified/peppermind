# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dito do
  	user 1
  	challenge 1

  	factory :invalid_dito do
  		user nil
  		challenge nil
   	end
  end
end
