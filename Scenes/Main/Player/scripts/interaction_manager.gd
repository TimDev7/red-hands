extends Area2D

var nearby_objects:Array[InteractionComponent]
@export var player_ref:Player

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("interaction"):
		if nearby_objects.is_empty():
			return
		var lowest_distance:float = INF
		var nearest_area:Area2D
		for object in nearby_objects:
			var distance:float = object.global_position.distance_squared_to(get_parent().position)
			if distance < lowest_distance:
				lowest_distance = distance
				nearest_area = object
		if nearest_area:
			nearest_area.interact(player_ref)


func _on_area_entered(area: Area2D) -> void:
	if area is InteractionComponent:
		area.show_hint()
		nearby_objects.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area is InteractionComponent:
		if nearby_objects.has(area):
			area.hide_hint()
			nearby_objects.pop_at(nearby_objects.find(area))
		
