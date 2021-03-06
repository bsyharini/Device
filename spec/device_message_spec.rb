# encoding: Windows-1252
require_relative '../device_message'
require 'spec_helper'
describe DeviceMessage do
	describe "Test cases to check the type of message received by the device" do
			before :each do					
				payload = {"id":49, 
						  "options":{ 
							"devices": "ios => 
					e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96", 
							"Alert_message": " You have following notifications ", 
							"badge_count":10, 
							"created_at":"2015­07­20T06:28:36­05:00", 
							"id":48, 
							"member_id":25, 
							"notification_type": "secure_message", 
							"silent":true, 
							"updated_at":"2015­07­20T06:28:36­05:00" }}
				dm1 =  FactoryGirl.build(:device_message, :payload => payload)
				@dm1 = DeviceMessage.new(dm1)
				
				payload = { 
							  "id":48, 
							  "options": 
							  { 
								"devices":"android => 
						e25454608b6097bc412be42ad9bf39797a698925d947b9d136cbb992f649cc96", 
								"Alert_message": "This is a sample push notification message", 
								"badge_count": 0, 
								"created_at":"2015­07­21T06:28:36­05:00", 
								"id":48, 
								"member_id":25, 
								"notification_type":"Reminder", 
								"silent":false, 
								"updated_at":"2015­07­21T06:28:36­05:00" 
							  } 
							} 
				dm2 =  FactoryGirl.build(:device_message, :payload => payload)
				@dm2 = DeviceMessage.new(dm2)
			
			end
			
		it "should create instance of DeviceMessage " do
			expect(@dm1.class).to equal(DeviceMessage)
		end
		
		it "Validate presence of message" do
			expect(@dm1.message).should_not be_nil 
		end
		
		it "Target should be 'apn' when device type is 'ios' " do
			expect(@dm1.target).to eql('apn') 
		end
		
		it "Message should contain messages count when popup is true" do
			message_count = @dm1.message.split('-').last.to_i
			expect(message_count.class).to equal(Fixnum) if @dm1.pop_up
		end
		
		it "Popup should be true for the notification type is secure" do
			expect(@dm1.pop_up).to equal(@dm1.message_type == 'secure_message')
		end
		
		it "Target should be 'apn' when device type is 'ios'" do
			expect(@dm1.target).not_to eq('gcm')
		end
		
		it "should create instance of DeviceMessage " do
			expect(@dm2.class).to equal(DeviceMessage)
		end
		
		it "Validate presence of message" do
			expect(@dm2.message).should_not be_nil 
		end
		
		it "Target should be 'gcm' when device type is 'android' " do
			expect(@dm2.target).to eql('gcm') 
		end
		
		it "Message should not contain messages count when popup is false" do
			message_count = @dm2.message.split('-').last.to_i
			expect(message_count).should be_nil if @dm1.pop_up == false
		end
		
		it "Popup should be false for the notification type is reminder" do
			expect(@dm1.pop_up).to equal(false) if (@dm1.message_type == 'Reminder')
		end
		
		it "Target should be 'gcm' when device type is 'ios'" do
			expect(@dm2.target).not_to eq('apn')
		end
		
		
		
		
		
		

	end
end
