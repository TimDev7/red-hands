extends Node
class_name CoreSaveManager

const DATA_SAVEPATH:String = "user://game_data.json"

var data_handler:Node
@onready var auto_save_timer = $AutoSaveTimer


func initialize(_data_handler:Node) -> void:
	data_handler = _data_handler
	load_data()


func load_data() -> void:
	data_handler.load_default_data()
	
	if !FileAccess.file_exists(DATA_SAVEPATH):
		save_data()
		return
	
	var default_save_time:int = int(Time.get_unix_time_from_system())
	
	var file = FileAccess.open(DATA_SAVEPATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	var parse_result = JSON.parse_string(content)
	if !parse_result:
		push_error("Error while parsing json!")
		Core.event_bus.emit_signal("game_data_loaded", default_save_time)
		return
		
	var loaded_data = parse_result
	
	data_handler.dict_to_game_data(loaded_data)
	Core.event_bus.emit_signal("game_data_loaded", loaded_data.get("save_time", default_save_time))
	


func save_data() -> void:
	auto_save_timer.start()
	
	var data:Dictionary = data_handler.game_data_to_dict()
	data["save_time"] = int(Time.get_unix_time_from_system())
	var json_data = JSON.stringify(data)
	var file = FileAccess.open(DATA_SAVEPATH,FileAccess.WRITE)
	file.store_string(json_data)
	file.close()


func _on_AutoSaveTimer_timeout():
	save_data()


func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		save_data()
	
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()
