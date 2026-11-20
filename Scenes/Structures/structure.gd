extends Node2D
class_name Structure

@export var world_tile_map: TileMapLayer

func _ready() -> void:
	$ChunkArea.queue_free()

func get_tile_map_ground_pattern() -> TileMapPattern:
	var tile_map_cells:Array[Vector2i]
	for y in range(0,Game.chunk_size):
		for x in range(0,Game.chunk_size):
			tile_map_cells.append(Vector2i(x,y))
	
	return world_tile_map.get_pattern(tile_map_cells)
