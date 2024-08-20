@icon("res://Assets/CustomNodeIcons/Velocity.png")
extends Node
class_name VelocityComponent


@export var speed: float = 50
@export var acceleration: float = 5
@export var velocity: Vector2

var moving = true

@export_range(0, 1) var speed_power: float = 1
@export_range(0, 0.2) var break_power: float = 0.2
@export_range(0, 0.1) var turn_factor: float = 0.1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving:
		speed_power = min(1, speed_power*(1 + break_power))
	else:
		speed_power = max(0, speed_power/(1 + break_power))
