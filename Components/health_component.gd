@icon("res://Assets/CustomNodeIcons/health_component.png")
extends Node
class_name HealthComponent

signal got_damage(amnt)
signal hp_increased(amnt)
signal hp_changed
signal hp_full
signal hp_depleted

@export var max_hp: float = 100
var hp: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp = max_hp

func damage(amount: float) -> void:
	hp -= amount
	got_damage.emit(amount)
	
	if hp <= 0:
		hp_depleted.emit()
	
	hp_changed.emit()

func heal(amount: float) -> void:
	hp += amount
	hp = min(max_hp, hp)
	hp_increased.emit(amount)
	
	if hp == max_hp:
		hp_full.emit()
	
	hp_changed.emit()
