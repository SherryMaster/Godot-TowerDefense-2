@icon("res://Assets/CustomNodeIcons/tank_wave_part.png")
extends Resource
class_name WavePartResource

var colors = {
	"Blue": Color(0.25, 0.5, 1),
	"Purple": Color(0.5, 0, 1),
	"Pink": Color(1, 0.5, 1),
	"Orange": Color(1, 0.5, 0.25),
	"Green": Color(0.5, 1, 0.25),
	"Red": Color(1, 0.25, 0.25),
	"Yellow": Color(1, 1, 0.5)
}

@export_group("Unit Detail")
@export_enum("Normal_Tank") var type: String = "Normal_Tank"
@export_enum("Blue", "Red", "Green", "Yellow", "Pink") var color: String = "Blue"

@export_group("Pattern Detail")
@export var amount: int = 5
@export var delay_btw_spawns: float = 1
@export var wait_after_pattern_complete: float = 1

@export_group("Loop Detail")
@export_enum("Start", "Stop", "No Loop") var loopings_state: String = "No Loop"
@export_range(0, 5, 1, "or_greater") var times_to_repeat: int = 0
