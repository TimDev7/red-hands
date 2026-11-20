extends AnimatedSprite2D

@export var text:String = ""


func _on_interactable_component_interacted(_player: Player) -> void:
	Game.print_in_chat.emit(text)
