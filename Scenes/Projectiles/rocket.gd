extends Projectile
class_name Rocket


func _ready() -> void:
	top_level = true
	hit_box_component.damage_to_deal = damage
	if projectile_type == Type.Bullet or projectile_type == Type.Rocket:
		hit_box_component.got_hit.connect(destroy)
	current_velocity = Vector2.RIGHT.rotated(rotation) * speed


func _physics_process(delta: float) -> void:
	if distance_travelled > max_distance:
		destroy()
	
	if mouse_debug:
		if global_position.distance_to(get_global_mouse_position()) < 10:
			destroy()
	
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
	$Sprite2D.visible = false
	$HitBoxComponent/CollisionShape2D.disabled = true
	$Flare.emitting = false
	$Timer.start()
	await $Timer.timeout
	queue_free()
