extends Resource
class_name WavePartResource

var colors = {
	"Blue": Color(0.25, 0.25, 1),
	"Purple": Color(0.5, 0, 1),
	"Pink": Color(1, 0.5, 1),
	"Orange": Color(1, 0.5, 0.25),
	"Green": Color(0.5, 1, 0.25),
	"Red": Color(1, 0.25, 0.25),
}

@export_category("Unit Detail")
@export_enum("Tank") var type: String = "Tank"
@export_enum("Red", "Green", "Blue", "Purple", "Pink", "Orange") var color: String = "Blue"
@export_range(1, 5) var level: int
@export var hp: int = 100
@export var speed: int = 50
@export_range(0, 0.1) var turn_factor = 0.1

@export_category("Pattern Detail")
@export var amount: int = 5
@export var delay_btw_spawns: float = 1
@export var wait_after_pattern_complete: float = 1
