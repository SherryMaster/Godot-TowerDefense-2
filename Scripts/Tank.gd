@icon("res://Assets/CustomNodeIcons/Tank.png")
extends CharacterBody2D
class_name Tank
signal destroyed()
signal reached_end(hp_left)


@export var main_target: Node2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var navigation_component: NavigationComponent = $NavigationComponent

var team_id: int = 2

var money_on_death: int
var max_hp
var speed

var path_points = []
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
	

	current_target = main_target
	target_position = current_target.global_position

	
	health_component.hp_depleted.connect(destroy)
	
	navigation_component.final_pos = main_target.global_position
	navigation_component.paths = path_points.map(func(point): return point.global_position) as Array[Vector2]
	navigation_component.start_navigation()
	navigation_component.reached_end.connect(func(): reached_at_end = true)

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

func distance_travelled():
	return navigation_component.distance_travelled
	
