extends BaseGame

# --- SIGNALS (game-specific, kept out of Template/) ---
signal print_in_chat(text:String)
signal update_light(dark:bool)

# --- WORLD (ported from Entropy's Curse GlobalVariables) ---
##Tile size in pixels with square shape.
const tile_size:int = 16
##Chunk size in tiles.
const chunk_size:int = 10
##World size in chunks. Must be divisible by chunk size without remainder.
const world_size:int = 5
##World size in pixels. Calculated during initialization.
var world_size_px:int

const ITEM_ATLAS = preload("uid://du0mgrd2aere0")


func _init() -> void:
	world_size_px = tile_size * chunk_size * world_size
