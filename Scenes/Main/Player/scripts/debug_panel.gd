extends PanelContainer

var current_state:String:
	set(value):
		current_state = value
		$VBoxContainer/Label.text = "current state: %s" % current_state
var character_position:String:
	set(value):
		character_position = value
		$VBoxContainer/Label2.text = "xy: %s" % character_position
var current_chunk:String:
	set(value):
		current_chunk = value
		$VBoxContainer/Label5.text = "chunk: (%s, %s)" % []

var direction:String:
	set(value):
		direction = value
		$VBoxContainer/Label3.text = "direction: %s" % direction
var fps:String:
	set(value):
		fps = value
		$VBoxContainer/Label4.text = "fps: %s" % fps

func _ready() -> void:
	visible = true

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("f3"):
		visible = not visible

func _process(_delta: float) -> void:
	fps = str(Engine.get_frames_per_second())
