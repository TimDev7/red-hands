extends Node

@export var loot_table:Array[ItemData]

func give_loot(target:CharacterBody2D) -> void:
	var inventory = target.get_node_or_null("Components/InventoryComponent")
	
	if inventory:
		for item in loot_table:
			var success = inventory.add_item(item,1)
			
			if success:
				pass
				#Game.print_in_chat.emit("%s moved successfully" % item.name)
			else:
				Game.print_in_chat.emit("Inventory is full!")
