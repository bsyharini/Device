# encoding: Windows-1252
FactoryGirl.define do
 factory :device_message do
	user_id 43
	managing_user_id 43 
	description "Push Notification" 
	effective_date "2015­07­20T06:28:36­05:00"
	system_date "2015­07­20T06:28:36­05:00" 
	trait :payload	do
	
	end
			
  initialize_with { {
	user_id: user_id, managing_user_id: managing_user_id, description: description, effective_date: effective_date, system_date: system_date, payload: payload  } }
end
end
	
