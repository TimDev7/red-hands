extends Control
class_name InventorySlot

signal move_item(from_slot:InventorySlot)

static var style_normal: StyleBoxTexture
static var style_hover: StyleBoxTexture

const SLOT_TEXTURE:Texture2D = preload("uid://bjebr0kx47b0q")
const SLOT_HOVER_TEXTURE:Texture2D = preload("uid://dmknqf28g3f5j")
const FEATURED_SLOT_TEXTURE:Texture2D= preload("uid://dm4dmwjbjbahn")
const FETURED_SLOT_HOVER_TEXTURE:Texture2D = preload("uid://brstc11sdkvji")

@onready var icon: TextureRect = $Icons/Icon
@onready var movable_icon: TextureRect = $Icons/MovableIcon
@onready var amount_label: Label = $AmountLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var featured:bool = false

var is_hovering:bool = false
var is_holding:bool = false
var holding_from_pos:Vector2


func _ready() -> void:
	movable_icon.visible = false
	if style_normal == null:
		style_normal = StyleBoxTexture.new()
		style_normal.texture = SLOT_TEXTURE
		
		style_hover = StyleBoxTexture.new()
		style_hover.texture = SLOT_HOVER_TEXTURE
	add_theme_stylebox_override("panel",get("theme_override_styles/panel").duplicate())


func set_slot_data(item_data:ItemData,amount:int) -> void:
	icon.texture = item_data.icon
	movable_icon.texture = item_data.icon
	amount_label.text = str(amount)


func clear_slot_data() -> void:
	icon.texture = null
	movable_icon.texture = null
	amount_label.text = ""


func _on_icon_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			_grab_item(event.position)

		elif event.is_released():
			_release_and_move_item()
		
	elif event is InputEventMouseMotion:
		_hold_item(event.global_position)


func _on_mouse_entered() -> void:
	is_hovering = true
	add_theme_stylebox_override("panel",style_hover)
	animation_player.play("hover")


func _on_mouse_exited() -> void:
	is_hovering = false
	add_theme_stylebox_override("panel",style_normal)
	animation_player.play("unhover")


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		if not is_visible_in_tree() and is_holding:
			_release_item()


func _grab_item(grab_from_pos:Vector2) -> void:
	icon.self_modulate = Color(1,1,1,0.5)
	movable_icon.visible = true
	is_holding = true
	holding_from_pos = grab_from_pos


func _hold_item(mouse_pos:Vector2) -> void:
	if is_holding:
		movable_icon.global_position = mouse_pos - holding_from_pos


func _release_item() -> void:
	icon.self_modulate = Color(1,1,1,1)
	movable_icon.visible = false
	is_holding = false
	movable_icon.position = Vector2(0.0,0.0)


func _release_and_move_item() -> void:
	_release_item()
	move_item.emit(self)
