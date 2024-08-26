extends Camera2D
class_name GameCamera

var can_move = false
var scale_factor = 0.98

@export var right_limit_node: Node2D
@export var bottom_limit_node: Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			can_move = true
		elif event.button_index == 1 and not event.pressed:
			can_move = false
		elif event.button_index == 4:
			zoom /= scale_factor
			zoom.x = min(zoom.x, 2.072)
			zoom.y = min(zoom.y, 2.072)
		elif event.button_index == 5:
			zoom *= scale_factor
			zoom.x = max(zoom.x, 0.504)
			zoom.y = max(zoom.y, 0.504)
	
	if event is InputEventMouseMotion:
		if can_move:
			global_position -= event.relative/get_screen_transform().x.x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	limit_right = right_limit_node.global_position.x
	limit_bottom = bottom_limit_node.global_position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = min(max(limit_left + (get_viewport_rect().size.x / 2) / get_screen_transform().x.x, global_position.x), limit_right - (get_viewport_rect().size.x / 2) / get_screen_transform().x.x)
	global_position.y = min(max(limit_top + (get_viewport_rect().size.y / 2) / get_screen_transform().x.x, global_position.y), limit_bottom - (get_viewport_rect().size.y / 2) / get_screen_transform().x.x)
	pass
