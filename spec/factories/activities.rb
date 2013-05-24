# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    user 1
    action "create"
    trackable_field nil
    trackable_type "Challenge"

    factory :invalid_activity do
    	user nil
    	action nil
    	trackable_field nil
    	trackable_type nil
    end
  end
end
