extends NavigationAgent2D
class_name NavigationComponent

@export var follow_mouse = false


var parent: Tank
@onready var velocity_component: VelocityComponent = $"../VelocityComponent"

var current_velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	
	current_velocity = Vector2.RIGHT.rotated(parent.rotation)
	
	set_path_postprocessing(NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if follow_mouse:
		parent.target_position = parent.get_global_mouse_position()
	
	var direction: Vector2
	target_position = parent.target_position
	
	direction = parent.global_position.direction_to(get_next_path_position())
	var desired_velocity := direction * velocity_component.speed
	
	var change = (desired_velocity - current_velocity) * velocity_component.turn_factor
	
	current_velocity += change
	
	parent.move_and_collide(current_velocity * velocity_component.speed_power * delta)
	parent.look_at(parent.global_position + current_velocity)


func _on_target_reached() -> void:
	velocity_component.moving = false
	parent.reached_at_end = true if parent.current_target == parent.main_target else false
	parent.target_position = Vector2.ZERO
