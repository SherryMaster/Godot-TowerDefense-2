extends Tower
class_name ShotgunTower

var tower_name: String = "shotgun_tower"
@export var number_of_shots: int = 3
@export var shot_spread: float = 45

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
		for i in range(number_of_shots):
			var shoot_point = shoot_points.get_child(0) as Marker2D
			var new_projectile = projectile_scene.instantiate() as Projectile
			new_projectile.setup_projectile(shoot_point.global_position, (shoot_point.global_rotation_degrees + randf_range(-shot_spread/2, shot_spread/2)) * PI/180, damage, projectile_speed * randf_range(0.9, 1.1), projectile_travel_distance, can_home_enemies)
			new_projectile.enemy = Enemy_to_hit
			projectiles.add_child(new_projectile)
		
		on_shoot_cooldown = true
		shoot_cooldown.start(reload)

func destroy():
	queue_free()

func _on_shoot_cooldown_timeout() -> void:
	on_shoot_cooldown = false
