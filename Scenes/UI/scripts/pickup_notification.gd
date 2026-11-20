extends PanelContainer

@onready var icon: TextureRect = $MarginContainer/HBoxContainer/Icon
@onready var pickuped_item_label: Label = $MarginContainer/HBoxContainer/PickupedItemLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var item_amount:int = 0
var item_data:ItemData

func init(_item_data:ItemData, _item_amount:int = 0) -> void:
	item_data = _item_data
	item_amount = _item_amount

func _ready() -> void:
	update_label()
	icon.texture = item_data.icon

func add_to_amount(value_to_add:int) -> void:
	item_amount += value_to_add
	update_label()

func update_label() -> void:
	animation_player.stop()
	animation_player.play("lifecycle")
	pickuped_item_label.text = "%s x%s" % [item_data.name,item_amount]


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	#Game.print_in_chat.emit("%s Notification deleted!" % item_data.name)
	queue_free()
