@icon("res://Assets/CustomNodeIcons/Detector.png")
extends Area2D
class_name DetectorComponent

# Area signals
signal hitbox_detected(hitbox: HitBoxComponent)
signal hurtbox_detected(hurtbox: HurtBoxComponent)

# Body Signals
signal tank_detected(tank: Tank)
signal tank_left(tank: Tank)
signal tower_detected(tower: Tower)
signal tower_left(tower: Tower)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		hitbox_detected.emit(area)
	if area is HurtBoxComponent:
		hurtbox_detected.emit(area)


func _on_area_exited(area: Area2D) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Tank:
		tank_detected.emit(body)
	if body is Tower:
		tower_detected.emit(body)


func _on_body_exited(body: Node2D) -> void:
	if body is Tank:
		tank_left.emit(body)
	if body is Tower:
		tower_left.emit(body)
