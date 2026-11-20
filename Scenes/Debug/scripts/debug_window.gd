extends CanvasLayer

@export var player:Player
@onready var fps_label: Label = $Control/StatsPanel/MarginContainer/VBoxContainer/FPSLabel
@onready var state_label: Label = $Control/StatsPanel/MarginContainer/VBoxContainer/StateLabel
@onready var position_label: Label = $Control/StatsPanel/MarginContainer/VBoxContainer/PositionLabel

func _ready() -> void:
	Game.connect("print_in_chat",print_in_chat)
	visible = Game.game_data.debug_mode

func _process(_delta: float) -> void:
	fps_label.text = "fps: %s" % Engine.get_frames_per_second()
	state_label.text = "player_state: %s" % player.current_state
	position_label.text = str(player.position.round())
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("f3"):
			visible = not visible
		if event.is_action_pressed("restart"):
			get_tree().reload_current_scene()
	

func print_in_chat(...args) -> void:
	var msg:String = ""
	for arg in args:
		msg += str(arg)
	$Control/ChatPanel/MarginContainer2/ScrollContainer/Label.text += "> %s\n" % msg
	$Control/ChatPanel/AnimationPlayer.play("activated")
	await get_tree().process_frame
	$Control/ChatPanel/MarginContainer2/ScrollContainer.scroll_vertical = 10000
	

func _on_sleep_timer_timeout() -> void:
	return
	#$Control/ChatPanel/AnimationPlayer.play("sleep")
