# Red Hands

Godot 4.7 (Mobile / gl_compatibility) project.

Built on **Core Template** (III generation: `Core` + `Game` autoloads) with the gameplay content of **Entropy's Curse** (player, enemies, inventory, items, chests, debug tools).

## Structure
- `Template/` — Core Template (generic, don't put game logic here)
  - `Core/` autoload: EventBus, SaveManager, SoundManager
  - `Game/` BaseGame, GameData, EventBus, Sounds
- `Game/` — Game-specific autoload (`Game.gd`: world constants `tile_size`, `chunk_size`, `world_size`)
- `Scenes/` — gameplay scenes (Entities, Items, Main/Player, Structures, UI, Debug)
- `Assets/` — fonts, palette, textures

## Migration notes (from Entropy's Curse)
Old autoloads were replaced:
| Old | New |
|---|---|
| `GV.debug_mode` | `Game.game_data.debug_mode` |
| `GV.tile_size / chunk_size / world_size / world_size_px` | `Game.*` |
| `SM.<signal>` | `Game.<signal>` (declared in `Game/Game.gd`) |

Not ported yet: old `Save`, `Sound`, `Background`, `GM`, `App` (screenshot hotkey, vsync, save-on-focus-out). Use Core's SaveManager/SoundManager instead.

Entry scene: `Scenes/Debug/test_space.tscn`.
