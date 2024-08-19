extends Node
class_name HealthComponent

signal got_damage(amnt)
signal hp_increased(amnt)
signal hp_changed
signal hp_full
signal hp_depleted


var stats_component: StatsComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stats_component = get_parent().get_node("StatsComponent") as StatsComponent
	stats_component.hp = stats_component.max_hp

func damage(amount: int) -> void:
	stats_component.hp -= amount
	got_damage.emit(amount)
	
	if stats_component.hp <= 0:
		hp_depleted.emit()
	
	hp_changed.emit()

func heal(amount: int) -> void:
	stats_component.hp += amount
	stats_component.hp = min(stats_component.max_hp, stats_component.hp)
	hp_increased.emit(amount)
	
	if stats_component.hp == stats_component.max_hp:
		hp_full.emit()
	
	hp_changed.emit()
