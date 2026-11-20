extends Node2D

@export var dark:bool = false:
	set(value):
		dark = value
		$CanvasModulate.visible = dark
		Game.update_light.emit(dark)

@export var character_body:CharacterBody2D

func _ready() -> void:
	set_limits_to_camera()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("num_1"):
		dark = not dark

func fill_world_with_floor() -> void:
	var cells:Array
	for y in Game.world_size * Game.chunk_size:
		for x in Game.world_size * Game.chunk_size:
			cells.append(Vector2i(x,y))
	
	
	$GroundLayer.set_cells_terrain_connect(cells,0,0)
	
func set_limits_to_camera() -> void:
	var world_size = $GroundLayer.get_used_rect()
	var camera_node:Camera2D = character_body.get_node("Camera2D")
	if !camera_node:
		return
	camera_node.limit_left = 0
	camera_node.limit_top = 0
	camera_node.limit_bottom = world_size.size.y * Game.tile_size
	camera_node.limit_right = world_size.size.x * Game.tile_size
