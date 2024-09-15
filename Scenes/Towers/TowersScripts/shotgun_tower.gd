extends Tower
class_name ShotgunTower

var tower_name: String = "shotgun_tower"
@export var number_of_shots: int = 3
@export var shot_spread: float = 45

func _ready() -> void:
	general_ready()

func _physics_process(delta: float) -> void:
	if not preview_mode:
		select_tank()
		target_tank()
		shoot()


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
