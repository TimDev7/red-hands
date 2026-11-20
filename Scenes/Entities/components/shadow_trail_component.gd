extends GPUParticles2D


func _ready() -> void:
	disable()


func enable() -> void:
	if !emitting:
		emitting = true


func disable() -> void:
	if emitting:
		emitting = false
