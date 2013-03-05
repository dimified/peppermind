# spec/factories/users.rb

FactoryGirl.define do
	factory :user do
		display_name {Faker::Internet.user_name}
		password "gravity1"
		email {Faker::Internet.email}

		factory :invalid_user do
			display_name nil
			password nil
			email nil
		end
	end
end