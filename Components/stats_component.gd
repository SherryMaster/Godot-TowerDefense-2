extends Node
class_name StatsComponent

var max_hp: float
var speed: float
var speed_power: float
var break_power: float 
@export_range(0, 0.1) var drag_factor: float = 0.1

@onready var health_component: HealthComponent = $"../HealthComponent"



@export var colored_variants_for_tanks = {
	"Blue": {
		"Hp": 15,
		"Speed": 50,
		"Coins on Death": 5,
	},
	"Red": {
		"Hp": 45,
		"Speed": 50,
		"Coins on Death": 15,
	},
	"Green": {
		"Hp": 135,
		"Speed": 50,
		"Coins on Death": 45,
	}
}
	
