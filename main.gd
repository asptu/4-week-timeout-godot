extends Control

func _ready():
	pass

func _on_Button_pressed():

	var unix_time = OS.get_unix_time()
	var timeout_time = unix_time + 2419200 
	var time = OS.get_datetime_from_unix_time(timeout_time)
	var year = time["year"]
	var month = time["month"]
	var day = time["day"]
	var hour = time["hour"]
	var minute = time["minute"]
	var second = time["second"]
	var timestamp = "%s-%s-%sT%s:%s:%s" % [year, month, day, hour, minute, second]
	
	var token = $Token_Input.text
	var guild_id = $GuildID_Input.text
	var user_id = $UserID_Input.text

	var url := 'https://discord.com/api/v9/guilds/' + str(guild_id) + "/members/" + str(user_id)
	var query := JSON.print({"communication_disabled_until": str(timestamp)})
	var headers := ["Authorization: %s" % token, "Content-Type: application/json"]
	$Button/HTTPRequest.request(url, headers, true, HTTPClient.METHOD_PATCH, query)




