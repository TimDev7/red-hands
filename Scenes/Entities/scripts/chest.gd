extends Node2D

enum States {CLOSED, OPENED, DESTROYED}

var current_state:States
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var damage_animation_player: AnimationPlayer = $DamageAnimationPlayer

@onready var health_component: HealthComponent = $Components/HealthComponent
@onready var hitbox_component: HitboxComponent = $Components/HitboxComponent
@onready var interactable_component: InteractionComponent = $Components/InteractableComponent
@onready var loot_component: Node = $Components/LootComponent

@export var loot_chances:Dictionary[ItemData,int]

func _ready() -> void:
	if get_tree().current_scene == self:
		const CAMERA_COMPONENT = preload("uid://bj315tlcx2l0l")
		$Components.add_child(CAMERA_COMPONENT.instantiate())

	#loot_component.loot_table = loot.duplicate()
	_enter_state(States.CLOSED)


func change_state(new_state:States) -> void:
	if current_state == new_state:
		return
	
	if current_state == States.DESTROYED:
		return
	
	current_state = new_state
	_enter_state(current_state)


func _enter_state(state:States) -> void:
	match state:
		States.CLOSED:
			animation_player.play("closed")
			hitbox_component.enable()
			interactable_component.enable()
			
		States.OPENED:
			animation_player.play("open")
			interactable_component.hide_hint()
			interactable_component.hint_text = ""
			interactable_component.disable()
			await animation_player.animation_finished
			health_component.set_health(1)
			#hitbox_component.disable()
			
		States.DESTROYED:
			animation_player.play("death")
			hitbox_component.disable()
			interactable_component.disable()
			await animation_player.animation_finished
			queue_free()
			

func _on_health_component_health_changed(_value: int) -> void:
	if current_state != States.DESTROYED:
		damage_animation_player.stop()
		damage_animation_player.play("damage")


func _on_health_component_died() -> void:
	change_state(States.DESTROYED)


func _on_interactable_component_interacted(player: Player) -> void:
	change_state(States.OPENED)
	
	if current_state == States.OPENED:
		loot_component.give_loot(player)
