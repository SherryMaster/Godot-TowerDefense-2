extends Area2D
class_name HurtBoxComponent

@onready var health_component: HealthComponent = $"../HealthComponent"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	mouse_entered.connect(_on_mouse_entered)
	set_collision_layer_value(5, true)
	set_collision_mask_value(6, true)
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: HitBoxComponent) -> void:
	pass


func _on_mouse_entered() -> void:
	if GamePlayData.damage_through_mouse:
		take_dmg(GamePlayData.mouse_damage)
		
func take_dmg(damage: float) -> void:
	health_component.damage(damage)
