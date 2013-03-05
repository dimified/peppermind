# spec/factories/users.rb

FactoryGirl.define do
	factory :user do
		display_name "IsaacNewton"
		password "gravity1"
		email "isaac_newton@email.com"
	end
end