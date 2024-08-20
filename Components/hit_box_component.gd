extends Area2D
class_name HurtBoxComponent

@onready var health_component: HealthComponent = $"../HealthComponent"

@export_group("Debug")
@export var debug_with_mouse: bool = false
@export var mouse_can_damage: bool = true
@export var mouse_damage: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_area_entered)
	mouse_entered.connect(mouse_debug)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_area_entered(body: Node2D) -> void:
	if body is ProjectileComponenet:
		health_component.damage(body.damage)
		body.destroy()


func mouse_debug() -> void:
	print("MOUSE!")
	if debug_with_mouse:
		if mouse_can_damage:
			health_component.damage(mouse_damage)
