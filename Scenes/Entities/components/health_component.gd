extends Node
class_name HealthComponent

signal died
signal health_changed(value:int)

@export var max_health:int = 100
var health:int:
	set(value):
		health = clamp(value,0,max_health)

func _ready() -> void:
	health = max_health

func set_health(value:int) -> void:
	health = value

func take_damage(damage:int) -> void:
	if health == 0:
		return
	
	set_health(health - damage)
	
	health_changed.emit(health)
	if health == 0:
		died.emit()
