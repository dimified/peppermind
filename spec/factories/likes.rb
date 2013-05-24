# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :like do
  	user 1
  	inspiration 1

  	factory :invalid_like do
  		user nil
  		inspiration nil
   	end
  end
end
