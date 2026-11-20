extends Control

const PICKUP_NOTIFICATION = preload("uid://vo72bka0o65g")

@export var inventory_component:InventoryComponent
@export var notifications_table:VBoxContainer

func _ready() -> void:
	inventory_component.connect("inventory_updated",_add_or_update_pickup_notification)


func _add_or_update_pickup_notification(item_data:ItemData, amount:int) -> void:
	if !item_data:
		return
	#Checking if you can update current notifications
	#Game.print_in_chat.emit(amount)
	for node_notification in notifications_table.get_children():
		if node_notification.item_data == item_data:
			node_notification.add_to_amount(amount)
			#Game.print_in_chat.emit("%s Notification updated" % item_data.name)
			return
	
	#Creating new notification
	var notification_instance = PICKUP_NOTIFICATION.instantiate()
	notification_instance.init(item_data,amount)
	#Game.print_in_chat.emit("%s Notification created!" % item_data.name)
	notifications_table.add_child(notification_instance)
	
