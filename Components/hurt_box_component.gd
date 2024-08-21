extends DetectorComponent
class_name HurtBoxComponent

@onready var health_component: HealthComponent = $"../HealthComponent"
@export var mouse_debugging: bool = false
@export var mouse_damage: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_detect_areas = true
	hitbox_detected.connect(_on_hitbox_detected)
	mouse_entered.connect(_on_mouse_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hitbox_detected(hitbox: HitBoxComponent) -> void:
	health_component.damage(hitbox.damage_to_deal)


func _on_mouse_entered() -> void:
	if mouse_debugging:
		health_component.damage(mouse_damage)
