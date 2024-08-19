extends Area2D
class_name ProjectileComponenet

var enemy: Node2D

@export_enum("Bullet", "Rocket") var projectile_type: String = "Bullet"

@export var damage: float = 10
@export var speed: float = 250
@export var can_home_to_enemies: bool = false

@export_range(0, 0.1) var homing_power: float = 0.1

var current_velocity: Vector2

# states
var shot_by_enemy: bool = false

func _ready() -> void:
	top_level = true
	
	current_velocity = Vector2.RIGHT.rotated(rotation) * speed


func _physics_process(delta: float) -> void:
	if projectile_type == "Bullet" or projectile_type == "Rocket":
		if can_home_to_enemies:
			var direction: Vector2 = global_position.direction_to(get_global_mouse_position())
			var desired_velocity := direction * speed
			
			var change = (desired_velocity - current_velocity) * homing_power
			
			current_velocity += change
		
		else:
			current_velocity += Vector2.RIGHT.rotated(rotation) * speed
	
	position += current_velocity * delta
	look_at(global_position + current_velocity)


func destroy():
	queue_free()
