extends Node2D
class_name Projectile
enum Type {Bullet, Rocket}

var enemy: Node2D
var last_enemy_pos: Vector2

@export var projectile_type: Type = Type.Bullet

@export var damage: float = 10
@export var speed: float = 2000
@export var max_distance: float = 2000
@export var can_home_to_enemies: bool = false

@export_range(0, 0.1) var homing_power: float = 0.05
@export var mouse_debug: bool

@onready var hit_box_component: HitBoxComponent = $HitBoxComponent

var destroyed: bool = false

var team_id: int = 1
var current_velocity: Vector2
var distance_travelled: float


# states
var shot_by_enemy: bool = false
var can_damage: bool = true

func setup_projectile(pos: Vector2, rot, dmg: float, spd: float, max_dist: float, can_home_enemies: bool):
	global_position = pos
	global_rotation = rot
	damage = dmg
	speed = spd
	max_distance = max_dist
	can_home_to_enemies = can_home_enemies
