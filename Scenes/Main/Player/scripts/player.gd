extends CharacterBody2D
class_name Player

enum States {IDLE, MOTION, FIGHT}

const SPEED:int = 96 #px per sec

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite

var current_state:States = States.IDLE:
	set(value):
		current_state = value

@export var ghost_mode:bool = false:
	set(value):
		ghost_mode = value
		$CollisionShape2D.disabled = ghost_mode
		z_index += 1
	get():
		if Game.game_data.debug_mode:
			return ghost_mode
		else:
			return false


func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")
	if direction:
		velocity = direction * SPEED
		if Input.is_action_pressed("run"):
			velocity *= 2
		_change_state(States.MOTION)
	else:
		velocity = Vector2.ZERO
		_change_state(States.IDLE)
	move_and_slide()
	
	position = Vector2(clamp(position.x,0.0,Game.world_size_px),clamp(position.y,0.0,Game.world_size_px))
	
	match_direction_animation(direction)
	

func match_direction_animation(direction:Vector2) -> void:
	if !direction:
		if _animated_sprite.animation != "":
			_animated_sprite.stop()
	else:
		if Input.is_action_pressed("run"):
			_animated_sprite.speed_scale = 2
		else:
			_animated_sprite.speed_scale = 1

		if round(direction.x) == -1.0:
			_animated_sprite.play("left")
		elif round(direction.x) == 1.0:
			_animated_sprite.play("right")
		elif round(direction.y) == -1.0:
			_animated_sprite.play("up")
		elif round(direction.y) == 1.0:
			_animated_sprite.play("down")
			#shadow_trail_component.set_texture(animated_sprite.sprite_frames.get_frame_texture("down",animated_sprite.frame))
		

func _change_state(new_state:States) -> void:
	if new_state == current_state:
		return

	current_state = new_state


func set_character_position(pos:Vector2) -> void:
	position = Vector2(clamp(pos.x,0,Game.world_size_px),clamp(pos.y,0,Game.world_size_px)) 
