extends Area2D
class_name InteractionComponent

signal interacted(player:Player)

@export var hint_text:String = ""
@onready var collision_shape:CollisionShape2D = $CollisionShape2D


func interact(player:Player) -> void:
	interacted.emit(player)


func _update_hint_text() -> void:
	$Label.text = hint_text


func show_hint() -> void:
	if !$Label.visible and $AnimationPlayer.current_animation != "hide_hint":
		$AnimationPlayer.stop()
		$AnimationPlayer.play("show_hint")


func hide_hint() -> void:
	if $Label.visible and $AnimationPlayer.current_animation != "hide_hint":
		$AnimationPlayer.stop()
		$AnimationPlayer.play("hide_hint")


func enable() -> void:
	set_deferred("monitoring",true)
	set_deferred("monitorable",true)
	collision_shape.set_deferred("disabled",false)

func disable() -> void:
	set_deferred("monitoring",false)
	set_deferred("monitorable",false)
	collision_shape.set_deferred("disabled",true)
