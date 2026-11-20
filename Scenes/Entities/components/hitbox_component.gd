extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent
@onready var collision_shape:CollisionShape2D = $CollisionShape2D

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		damage(10)


func damage(value:int) -> void:
	if health_component:
		health_component.take_damage(value)


func enable() -> void:
	set_deferred("monitoring",true)
	set_deferred("monitorable",true)
	collision_shape.set_deferred("disabled",false)


func disable() -> void:
	set_deferred("monitoring",false)
	set_deferred("monitorable",false)
	collision_shape.set_deferred("disabled",true)
