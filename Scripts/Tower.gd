@icon("res://Assets/CustomNodeIcons/tower.png")
extends CharacterBody2D
class_name Tower

enum TargetPriority {First, Last, Farthest, Closest, Strongest, Weakest}

var team_id = 1

@export var projectile_scene: PackedScene = preload("res://Scenes/Projectiles/bullet.tscn")
@export var tower_range: float = 6
@export var damage: float = 5
@export var projectile_speed: float = 300
@export var projectile_travel_distance: float = 2000
@export var reload: float = 1
@export var can_home_enemies: bool = false
@export var health:float = 100

@export var taget_prior: TargetPriority = TargetPriority.First
@export var turret: Node2D


@onready var health_component: HealthComponent = $HealthComponent
@onready var detector_component: DetectorComponent = $DetectorComponent
@onready var collision_shape_2d: CollisionShape2D = $DetectorComponent/CollisionShape2D
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var shoot_points: Node2D = $Turret/ShootPoints
@onready var projectiles: Node2D = $Projectiles

var Enemy_to_hit: Tank
var Enemy_List: Array[Tank]

#states
var on_shoot_cooldown = false
