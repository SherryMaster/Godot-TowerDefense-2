extends NavigationAgent2D
class_name NavigationComponent

signal reached_end

@export var follow_mouse = false

var parent: Tank
@onready var velocity_component: VelocityComponent = $"../VelocityComponent"

var paths
var path_index = 0

var distance_travelled: float

var final_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	
	velocity = Vector2.RIGHT.rotated(owner.rotation)
	set_path_postprocessing(NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED)
	
	target_reached.connect(_on_target_reached)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	#if follow_mouse:
		#parent.target_position = parent.get_global_mouse_position()
	
	if is_navigation_finished():
		if paths.size():
			paths.remove_at(0)
		
		if paths.size():
			update_path()
		else:
			reached_end.emit()
	
	var direction: Vector2
	
	direction = owner.global_position.direction_to(get_next_path_position())
	var desired_velocity := direction * velocity_component.speed
	
	var change = (desired_velocity - velocity) * velocity_component.turn_factor
	
	velocity += change
	
	owner.move_and_collide(velocity * velocity_component.speed_power * delta)
	owner.look_at(owner.global_position + velocity)
	distance_travelled += velocity.length() * velocity_component.speed_power * delta


func _on_target_reached() -> void:
	pass
		
	#if stop_on_reach:
		#velocity_component.moving = false

func update_path():
	target_position = paths[0]

func start_navigation():
	update_path()
