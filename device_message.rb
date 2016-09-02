class DeviceMessage
	def initialize(message_info = {})

			properties = message_info[:properties]
			payload_options = message_info[:payload][:options]
			alert_message = payload_options[:Alert_message]
			badge_count = payload_options[:badge_count]
			device = message_info[:payload][:options][:devices].split('=>')
			device_type = device.first.strip
			@user_id = properties[:user_id]
			@message = payload_options[:silent] ? (alert_message + badge_count.to_s).strip : alert_message.strip 
			@message_type = payload_options[:notification_type]
			@publish_at =  properties[:effective_date]
			@target = (device_type == 'ios') ? 'apn' : 'gcm'
			@device_id = device.last.strip
			@pop_up = payload_options[:silent]
			
			@managing_user_id = properties[:managind_user_id]
			@description = properties[:description]
			@system_date = properties[:system_date]
			@payload_id = message_info[:payload][:id]
			@payload_options_id = payload_options[:id]
			@member_id = payload_options[:member_id]
	end
	def message_details
		{:user_id => @user_id, :message => @message, :message_type => @message_type,
				   :pop_up => @pop_up, :publish_at => @publish_at, :target => @target, 
				   :device_id => @device_id}	
	end
end

message_info1 = { 
  "properties": { 
    "user_id":43, 
    "managing_user_id":43, 
    "description":"Push Notification", 
    "effective_date":"2015­07­20T06:28:36­05:00", 
    "system_date":"2015­07­20T06:28:36­05:00"}, 
    "payload":{ 
      "id":49, 
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
        "updated_at":"2015­07­20T06:28:36­05:00" 
      } 
    } 
  } 


dm1 = DeviceMessage.new(message_info1)
details = dm1.message_details
puts "************* OUTOUT 1 ****************"
puts details.inspect


message_info2 =  { 
    "properties": { 
      "user_id":43, 
      "managing_user_id":43, 
      "description":"Push Notification", 
      "effective_date":"2015­07­21T06:28:36­05:00", 
      "system_date":"2015­07­21T06:28:36­05:00" 
    }, 
    "payload": 
    { 
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
}

dm2 = DeviceMessage.new(message_info2)
details = dm2.message_details
puts "************* OUTOUT 2 ****************"
puts details.inspect

