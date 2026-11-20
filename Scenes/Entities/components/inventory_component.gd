extends Node
class_name InventoryComponent
signal inventory_updated(item:ItemData,amount:int)

class Slot:
	var item:ItemData
	var amount:int
	func _init(_item:ItemData, _amount: int) -> void:
		item = _item
		amount = _amount

@export var inventory_size:int
var slots:Array[Slot]

func _ready() -> void:
	slots.resize(inventory_size)

func add_item(item:ItemData, amount:int) -> bool:
	var amount_origin:int = amount
	if item.stack > 1:
		for slot in slots:
			if slot != null and slot.item == item and slot.amount < item.stack:
				var space:int = item.stack - slot.amount
				var to_add:int = min(space,amount)
				
				slot.amount += to_add
				amount -= to_add
				
				if amount == 0:
					inventory_updated.emit(item,amount_origin)
					return true

	if amount > 0:
		for i in range(slots.size()):
			if slots[i] == null:
				slots[i] = Slot.new(item,amount)
				inventory_updated.emit(item,amount_origin)
				return true

	#inventory_updated.emit()
	return false

func swap_slots(slot_id_1:int,slot_id_2:int) -> void:
	var buf:Slot = slots[slot_id_2]
	slots[slot_id_2] = slots[slot_id_1]
	slots[slot_id_1] = buf
	inventory_updated.emit(null,0)

func get_inventory_data() -> Array[Slot]:
	return slots
