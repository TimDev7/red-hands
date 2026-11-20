extends Node2D

@export_range(1.0,50.0) var camera_step_in_precent:int = 10
@export var enabled:bool = false
@onready var camera_2d: Camera2D = $Camera2D
var camera_zoom:Vector2:
	set(value):
		camera_zoom = value.clamp(Vector2(0.1,0.1),Vector2(10.0,10.0))
		_smooth_zoom_to(camera_zoom)
		
			

func _ready() -> void:
	camera_zoom = camera_2d.zoom
	if !enabled:
		queue_free()

func _smooth_zoom_to(value:Vector2) -> void:
	var tween = create_tween()
	tween.tween_property(camera_2d,"zoom",value,0.1)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("zoom_in"):
			camera_zoom += camera_2d.zoom * camera_step_in_precent * 0.01
		elif event.is_action_pressed("zoom_out"):
			camera_zoom -= camera_2d.zoom * camera_step_in_precent * 0.01
	
