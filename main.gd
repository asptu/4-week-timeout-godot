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

	var hour_str = str(hour)
	var minute_str = str(minute)
	if hour_str.length() == 1:
		hour = "0" + hour_str
	if minute_str.length() == 1:
		minute = "0" + minute_str
	
	var timestamp = "%s-%s-%sT%s:%s:%s" % [year, month, day, hour, minute, second]
	
	var token = $Token_Input.text
	var guild_id = $GuildID_Input.text
	var user_id = $UserID_Input.text

	var url := 'https://discord.com/api/v9/guilds/' + str(guild_id) + "/members/" + str(user_id)
	var query := JSON.print({"communication_disabled_until": str(timestamp)})
	var headers := ["Authorization: %s" % token, "Content-Type: application/json"]

	$Button/HTTPRequest.request(url, headers, true, HTTPClient.METHOD_PATCH, query)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):

	if response_code == 200:
		$Button.text = "💥💥💥destroyed"
		yield(get_tree().create_timer(2), "timeout")
		$Button.text = "boop"
	else:
		$Button.text = "something went wrong, check your inputs"
		yield(get_tree().create_timer(2), "timeout")
		$Button.text = "boop"
