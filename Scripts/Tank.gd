@icon("res://Assets/CustomNodeIcons/Tank.png")
extends CharacterBody2D
class_name Tank
signal destroyed()
signal reached_end(hp_left)


@export var main_target: Node2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent

var team_id: int = 2

var money_on_death: int
var speed
var max_hp

var distance_travelled: float

var current_target: Node2D
var target_position: Vector2
var color: Color

# states
var reached_at_end = false
var moving = true
func _ready() -> void:
	
	$Hull.modulate = color
	health_component.hp = max_hp
	health_component.max_hp = max_hp
	
	velocity_component.speed = speed
	
	if main_target:
		current_target = main_target
		target_position = current_target.global_position
	else:
		target_position = global_position
	
	health_component.hp_depleted.connect(destroy)

func _physics_process(delta: float) -> void:
	if reached_at_end:
		reached_end.emit(health_component.hp)
		destroy()
	
	if not target_position:
		target_position = global_position

func get_hp():
	return health_component.hp

func destroy():
	if not reached_at_end:
		GamePlayData.map_money += money_on_death
	destroyed.emit()
	queue_free()
	
