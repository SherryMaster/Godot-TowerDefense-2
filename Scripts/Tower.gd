@icon("res://Assets/CustomNodeIcons/tower.png")
extends CharacterBody2D
class_name Tower

enum TargetPriority {First, Last, Farthest, Closest, Strongest, Weakest}
enum ShootingStyle {Single}

var team_id = 1

@export var tower_name: String = "scout_tower"
@export var projectile_scene: PackedScene = preload("res://Scenes/Projectiles/bullet.tscn")
@export var tower_range: float = 6
@export var damage: float = 5
@export var bullet_speed: float = 300
@export var bullet_travel_distance: float = 2000
@export var reload: float = 1
@export var can_home_enemies: bool = false
@export var health:float = 100

@export var taget_prior: TargetPriority = TargetPriority.First
@export var shooting_style: ShootingStyle = ShootingStyle.Single


@onready var health_component: HealthComponent = $HealthComponent
@onready var detector_component: DetectorComponent = $DetectorComponent
@onready var collision_shape_2d: CollisionShape2D = $DetectorComponent/CollisionShape2D
@onready var turret: Sprite2D = $Turret
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var shoot_points: Node2D = $Turret/ShootPoints
@onready var projectiles: Node2D = $Projectiles

var Enemy_to_hit: Tank
var Enemy_List: Array[Tank]

#states
var on_shoot_cooldown = false

func _ready() -> void:
	health_component.hp = health
	health_component.max_hp = health
	
	health_component.hp_depleted.connect(destroy)
	
	detector_component.get_node("CollisionShape2D").shape.radius = 32 * tower_range
	detector_component.tank_detected.connect(on_tank_detected)
	detector_component.tank_left.connect(on_tank_left)
	
	shoot_cooldown.timeout.connect(_on_shoot_cooldown_timeout)

func _physics_process(delta: float) -> void:
	select_tank()
	target_tank()
	shoot()

func target_tank():
	if Enemy_to_hit:
		turret.look_at(Enemy_to_hit.global_position)

func on_tank_detected(tank: Tank):
	Enemy_List.append(tank)
	
func on_tank_left(tank: Tank):
	Enemy_List.erase(tank)

func select_tank():
	if Enemy_List.size() == 0:
		Enemy_to_hit = null
		return
	
	if taget_prior == TargetPriority.First:
		var distances: Array[float]
		for t in Enemy_List:
			distances.append(t.distance_travelled)
		var max_dist_index: int = distances.find(distances.max())
		Enemy_to_hit = Enemy_List[max_dist_index]
	
	if taget_prior == TargetPriority.Last:
		var distances: Array[float]
		for t in Enemy_List:
			distances.append(t.distance_travelled)
		var min_dist_index: int = distances.find(distances.min())
		Enemy_to_hit = Enemy_List[min_dist_index]
	
	if taget_prior == TargetPriority.Strongest:
		var hps: Array[float]
		for t in Enemy_List:
			hps.append(t.get_hp())
		var max_hp_index: int = hps.find(hps.max())
		Enemy_to_hit = Enemy_List[max_hp_index]
	
	if taget_prior == TargetPriority.Weakest:
		var hps: Array[float]
		for t in Enemy_List:
			hps.append(t.get_hp())
		var min_hp_index: int = hps.find(hps.min())
		Enemy_to_hit = Enemy_List[min_hp_index]
	
	if taget_prior == TargetPriority.Farthest:
		var distances: Array[float]
		for t in Enemy_List:
			distances.append(global_position.distance_to(t.global_position))
		var max_dist_index: int = distances.find(distances.max())
		Enemy_to_hit = Enemy_List[max_dist_index]
	
	if taget_prior == TargetPriority.Closest:
		var distances: Array[float]
		for t in Enemy_List:
			distances.append(global_position.distance_to(t.global_position))
		var min_dist_index: int = distances.find(distances.min())
		Enemy_to_hit = Enemy_List[min_dist_index]

func shoot():
	if not on_shoot_cooldown and Enemy_to_hit:
		if shooting_style == ShootingStyle.Single:
			var shoot_point = shoot_points.get_child(0) as Marker2D
			var new_projectile = projectile_scene.instantiate() as Projectile
			new_projectile.setup_projectile(shoot_point, damage, bullet_speed, bullet_travel_distance, can_home_enemies)
			projectiles.add_child(new_projectile)
		
		on_shoot_cooldown = true
		shoot_cooldown.start(reload)

func destroy():
	queue_free()

func _on_shoot_cooldown_timeout() -> void:
	on_shoot_cooldown = false
