extends Projectile
class_name Rocket

@onready var damage_radius: Area2D = $DamageRadius
@onready var flare: GPUParticles2D = $Flare
@onready var timer: Timer = $Timer
@onready var explosion: GPUParticles2D = $Explosion

func _ready() -> void:
	top_level = true
	hit_box_component.damage_to_deal = damage
	if projectile_type == Type.Bullet or projectile_type == Type.Rocket:
		hit_box_component.got_hit.connect(destroy)
	current_velocity = Vector2.RIGHT.rotated(rotation) * speed


func _physics_process(delta: float) -> void:
	if not destroyed:
		if distance_travelled > max_distance:
			destroy()
		
		if mouse_debug:
			if global_position.distance_to(get_global_mouse_position()) < 10:
				destroy()
		
		if can_home_to_enemies:
			var direction: Vector2 
			if mouse_debug:
				direction = global_position.direction_to(get_global_mouse_position())
			else:
				if is_instance_valid(enemy):
					direction = global_position.direction_to(enemy.global_position)
				else:
					current_velocity = Vector2.RIGHT.rotated(rotation) * speed
					select_new_enemy()

			var desired_velocity := direction * speed
			
			var change = (desired_velocity - current_velocity) * homing_power
			
			current_velocity += change
		
		else:
			current_velocity = Vector2.RIGHT.rotated(rotation) * speed
		
		position += current_velocity * delta
		distance_travelled += current_velocity.length() * delta
		look_at(global_position + current_velocity)


func select_new_enemy():
	
	var enemy_tanks: Array = get_tree().get_nodes_in_group("Enemy")
	
	var tank_distances: Array[float] = []
	for tank in enemy_tanks as Array[Tank]:
		tank_distances.append(global_position.distance_to(tank.global_position))
	
	var minimum_distance = tank_distances.min()
	var index = tank_distances.find(minimum_distance)
	
	if index != -1:
		enemy = enemy_tanks[index]

func destroy():
	$Sprite2D.visible = false
	hit_box_component.queue_free()
	flare.emitting = false
	explosion.emitting = true
	var bodies = damage_radius.get_overlapping_bodies()
	bodies.filter(func(body): return body is Tank)
	
	for tank in bodies as Array[Tank]:
		if tank.team_id != team_id:
			tank.health_component.damage(damage)
	
	destroyed = true
	timer.start()
	await timer.timeout
	queue_free()
