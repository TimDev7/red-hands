extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var inventory_component:InventoryComponent
@onready var inventory_slots: GridContainer = $Control/PanelContainer/InventorySlots

func _ready() -> void:
	for i in range(inventory_component.inventory_size):
		var slot_instance = preload("res://Scenes/UI/scenes/slot.tscn").instantiate()
		slot_instance.connect("move_item",try_to_move_item)
		inventory_slots.add_child(slot_instance)
		


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("inventory") and not animation_player.is_playing():
			if not $Control.visible:
				animation_player.play("open")
			else:
				animation_player.play("close")
		elif event.is_action_pressed("esc") and not animation_player.is_playing():
			if $Control.visible:
				animation_player.play("close")


func _on_inventory_component_inventory_updated(_item: ItemData, _amount: int) -> void:
	update_inventory_ui(inventory_component.get_inventory_data())


func update_inventory_ui(inventory_data:Array) -> void:
	var slots = inventory_slots.get_children()
	for slot in range(slots.size()):
		if inventory_data[slot]:
			slots[slot].set_slot_data(inventory_data[slot].item,inventory_data[slot].amount)
		else:
			slots[slot].clear_slot_data()


func try_to_move_item(from_slot:InventorySlot) -> void:
	var to_slot:InventorySlot
	for slot in inventory_slots.get_children():
		if slot is InventorySlot and slot.is_hovering:
			to_slot = slot
			break
	if to_slot:
		inventory_component.swap_slots(from_slot.get_index(),to_slot.get_index())
