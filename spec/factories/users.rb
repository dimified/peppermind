FactoryGirl.define do
	factory :user do
		display_name {Faker::Internet.user_name}
		password "gravity1"
		email {Faker::Internet.email}
		points 1
		level :rookie
		confirmed_at Time.new(2013)

		factory :invalid_user do
			display_name nil
			password nil
			email nil
			points nil
			level nil
			confirmed_at nil
		end
	end
end