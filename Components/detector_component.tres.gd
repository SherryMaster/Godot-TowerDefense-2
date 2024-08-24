@icon("res://Assets/CustomNodeIcons/Detector.png")
extends Area2D
class_name DetectorComponent

# General Signals
signal body_detected(body: Node2D)
signal body_left(body: Node2D)
signal area_detected(area: Area2D)
signal area_left(area: Area2D)

# Area Specific signals
signal hitbox_detected(hitbox: HitBoxComponent)
signal hurtbox_detected(hurtbox: HurtBoxComponent)

@export var can_detect_bodies: bool = false
@export var can_detect_areas: bool = false

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
	if can_detect_areas:
		area_detected.emit(area)
		if area is HitBoxComponent:
			hitbox_detected.emit(area)
		if area is HurtBoxComponent:
			hurtbox_detected.emit(area)


func _on_area_exited(area: Area2D) -> void:
	if can_detect_areas:
		area_left.emit(area)


func _on_body_entered(body: Node2D) -> void:
	if can_detect_bodies:
		body_detected.emit(body)


func _on_body_exited(body: Node2D) -> void:
	if can_detect_bodies:
		body_left.emit(body)
