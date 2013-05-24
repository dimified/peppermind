# spec/factories/socialproviders.rb

FactoryGirl.define do 
	factory :socialprovider do
		user_id 1
		display_name "testuser"
		email "test@user.com"
		uid "492083552"
		provider "twitter"

		factory :invalid_socialprovider do 
			user_id nil
		  display_name nil
		  email nil
		  uid nil
		  provider nil
		end
	end
end