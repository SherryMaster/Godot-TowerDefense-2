extends Projectile
class_name Bullet

@onready var trail: Node2D = $Trail
@export var trail_length = 20

func _ready() -> void:
	top_level = true
	hit_box_component.damage_to_deal = damage
	hit_box_component.got_hit.connect(destroy)
	
	current_velocity = Vector2.RIGHT.rotated(rotation) * speed


func _physics_process(delta: float) -> void:
	if not destroyed:
		if distance_travelled > max_distance:
			destroy()
			
		if can_home_to_enemies:
			var direction: Vector2 
			if mouse_debug:
				direction = global_position.direction_to(get_global_mouse_position())
			else:
				if is_instance_valid(enemy):
					direction = global_position.direction_to(enemy.global_position)

			var desired_velocity := direction * speed
			
			var change = (desired_velocity - current_velocity) * homing_power
			
			current_velocity += change
		
		else:
			current_velocity = Vector2.RIGHT.rotated(rotation) * speed
		
		position += current_velocity * delta
		distance_travelled += current_velocity.length() * delta
		look_at(global_position + current_velocity)

func destroy():
	destroyed = true
	$HitBoxComponent.queue_free()
	queue_free()
