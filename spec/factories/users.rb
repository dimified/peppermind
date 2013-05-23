FactoryGirl.define do
	factory :user do
		display_name {Faker::Internet.user_name}
		password "gravity1"
		email {Faker::Internet.email}
		points 0
		level :rookie

		factory :invalid_user do
			display_name nil
			password nil
			email nil
			points nil
			level nil
		end
	end
end