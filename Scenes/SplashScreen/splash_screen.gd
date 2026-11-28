extends Node

@onready var color_rect: ColorRect = %ColorRect
@onready var h_box_container: HBoxContainer = $Control/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_box_container.modulate = Color(1,1,1,0)
	var tween := create_tween()
	tween.tween_property(h_box_container,"modulate", Color(1,1,1,1),0.5)
	Core.sound_manager.play_sfx(Game.game_data.sounds.SPLASH_SCREEN)
	tween.tween_await(get_tree().create_timer(4.0).timeout)
	tween.tween_property(h_box_container,"modulate", Color(1,1,1,0),0.5)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
