@icon("res://Assets/CustomNodeIcons/Tank.png")
extends CharacterBody2D
class_name Tank
signal destroyed
signal reached_end


@export var main_target: Node2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent

var money_on_death: int
var speed
var max_hp

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
	destroyed.emit()
	queue_free()
	
