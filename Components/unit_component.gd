extends CharacterBody2D
class_name UnitComponent


@export var main_target: Node2D

@onready var stats_component: StatsComponent = $StatsComponent

var current_target: Node2D
var target_position: Vector2

# states
var reached_at_end = false
var moving = true
func _ready() -> void:
	if main_target:
		target_position = main_target.global_position
	else:
		target_position = global_position

func _physics_process(delta: float) -> void:
	if reached_at_end:
		destroy()
	
	if not target_position:
		target_position = global_position
	
	if not moving:
		stats_component.speed_power = max(0, stats_component.speed_power/(1 + stats_component.break_power))
	else:
		stats_component.speed_power = min(1, stats_component.speed_power*(1 + stats_component.break_power))

func destroy():
	queue_free()
	
