extends Node2D
class_name Projectile
enum Type {Bullet, Rocket}

var enemy: Node2D

@export var projectile_type: Type = Type.Bullet

@export var damage: float = 10
@export var speed: float = 2000
@export var max_distance: float = 2000
@export var can_home_to_enemies: bool = false

@export_range(0, 0.1) var homing_power: float = 0.05
@export var mouse_debug: bool

@onready var hit_box_component: HitBoxComponent = $HitBoxComponent
@onready var trail: Line2D = $Trail
var trail_length = 10

var team_id: int = 1
var current_velocity: Vector2
var distance_travelled: float

# states
var shot_by_enemy: bool = false
var can_damage: bool = true

func _ready() -> void:
	trail.top_level = true
	top_level = true
	hit_box_component.damage_to_deal = damage
	if projectile_type == Type.Bullet or projectile_type == Type.Rocket:
		hit_box_component.got_hit.connect(destroy)
	current_velocity = Vector2.RIGHT.rotated(rotation) * speed


func _physics_process(delta: float) -> void:
	if distance_travelled > max_distance:
		destroy()
	trail.add_point(global_position)
	if trail.get_point_count() > trail_length:
		trail.remove_point(0)
	if projectile_type == Type.Bullet or projectile_type == Type.Rocket:
		if can_home_to_enemies:
			var direction: Vector2 = global_position.direction_to(get_global_mouse_position() if mouse_debug else enemy.global_position)
			var desired_velocity := direction * speed
			
			var change = (desired_velocity - current_velocity) * homing_power
			
			current_velocity += change
		
		else:
			current_velocity += Vector2.RIGHT.rotated(rotation) * speed
	
	position += current_velocity * delta
	distance_travelled += current_velocity.length() * delta
	look_at(global_position + current_velocity)

func setup_projectile(marker: Marker2D, dmg: float, spd: float, max_dist: float, can_home_enemies: bool):
	global_position = marker.global_position
	global_rotation = marker.global_rotation
	damage = dmg
	speed = spd
	max_distance = max_dist
	can_home_to_enemies = can_home_enemies

func destroy():
	queue_free()
