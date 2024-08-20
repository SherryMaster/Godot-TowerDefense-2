@icon("res://Assets/CustomNodeIcons/Tank.png")
extends CharacterBody2D
class_name Tank

signal reached_end


@export var main_target: Node2D

@onready var health_component: HealthComponent = $HealthComponent

var money_on_death: int

var current_target: Node2D
var target_position: Vector2
var color: Color

# states
var reached_at_end = false
var moving = true
func _ready() -> void:
	if main_target:
		target_position = main_target.global_position
		current_target = main_target
	else:
		target_position = global_position
	
	health_component.hp_depleted.connect(destroy)

func _physics_process(delta: float) -> void:
	if reached_at_end:
		reached_end.emit()
		destroy()
	
	if not target_position:
		target_position = global_position

func destroy():
	queue_free()
	
