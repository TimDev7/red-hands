extends TileMapLayer

func fill_world_with_index_blocks() -> void:
	if !Game.game_data.debug_mode:
		return
	for y in range(0,Game.world_size * Game.chunk_size):
		for x in range(0,Game.world_size * Game.chunk_size):
			set_cell(Vector2i(x,y),0, Vector2i(0,0),1)
