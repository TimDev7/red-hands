extends PointLight2D
class_name LightComponent

var default_energy:float

func _ready() -> void:
	Game.connect("update_light",update_light)
	default_energy = energy

func update_light(activate:bool) -> void:
	var tween = create_tween()
	if activate:
		enabled = true
		energy = 0
		tween.tween_property(self,"energy",default_energy,0)
	elif !activate: 
		energy = default_energy
		tween.tween_property(self,"energy",0,0)
		await tween.finished
		enabled = false
