@icon("res://Assets/CustomNodeIcons/tank_wave_part.png")
extends Resource
class_name WavePart
enum Colors { BLUE, RED, GREEN, YELLOW, PINK, ORANGE, PURPLE, CYAN, MAGENTA, LIME, TEAL, VIOLET, INDIGO, TURQUOISE, SCARLET, AMBER, CRIMSON, EMERALD, SAPPHIRE, RUBY, CORAL, AQUA, LAVENDER, MAROON, OLIVE, GOLD, SILVER, BRONZE, COPPER, PLATINUM, TITANIUM, OBSIDIAN, ONYX, IVORY, CHARCOAL, GRAPHITE, STEEL, QUARTZ, DIAMOND, PEARL}
enum Type {Normal_Tank}

var colors = {
	Colors.BLUE: Color(0, 0, 1),
	Colors.RED: Color(1, 0, 0),
	Colors.GREEN: Color(0, 1, 0),
	Colors.YELLOW: Color(1, 1, 0),
	Colors.PINK: Color(1, 0.75, 0.8),
	Colors.ORANGE: Color(1, 0.5, 0),
	Colors.PURPLE: Color(0.5, 0, 0.5),
	Colors.CYAN: Color(0, 1, 1),
	Colors.MAGENTA: Color(1, 0, 1),
	Colors.LIME: Color(0.75, 1, 0),
	Colors.TEAL: Color(0, 0.5, 0.5),
	Colors.VIOLET: Color(0.56, 0, 1),
	Colors.INDIGO: Color(0.29, 0, 0.51),
	Colors.TURQUOISE: Color(0.25, 0.88, 0.82),
	Colors.SCARLET: Color(1, 0.14, 0),
	Colors.AMBER: Color(1, 0.75, 0),
	Colors.CRIMSON: Color(0.86, 0.08, 0.24),
	Colors.EMERALD: Color(0.31, 0.78, 0.47),
	Colors.SAPPHIRE: Color(0.06, 0.32, 0.73),
	Colors.RUBY: Color(0.88, 0.07, 0.37),
	Colors.CORAL: Color(1, 0.5, 0.31),
	Colors.AQUA: Color(0, 1, 1),
	Colors.LAVENDER: Color(0.9, 0.9, 0.98),
	Colors.MAROON: Color(0.5, 0, 0),
	Colors.OLIVE: Color(0.5, 0.5, 0),
	Colors.GOLD: Color(1, 0.84, 0),
	Colors.SILVER: Color(0.75, 0.75, 0.75),
	Colors.BRONZE: Color(0.8, 0.5, 0.2),
	Colors.COPPER: Color(0.72, 0.45, 0.2),
	Colors.PLATINUM: Color(0.9, 0.89, 0.89),
	Colors.TITANIUM: Color(0.75, 0.76, 0.78),
	Colors.OBSIDIAN: Color(0.06, 0.06, 0.06),
	Colors.ONYX: Color(0.21, 0.22, 0.22),
	Colors.IVORY: Color(1, 1, 0.94),
	Colors.CHARCOAL: Color(0.21, 0.27, 0.31),
	Colors.GRAPHITE: Color(0.18, 0.18, 0.18),
	Colors.STEEL: Color(0.69, 0.77, 0.87),
	Colors.QUARTZ: Color(0.85, 0.85, 0.95),
	Colors.DIAMOND: Color(0.97, 0.97, 1),
	Colors.PEARL: Color(0.94, 0.92, 0.84)
}


@export_group("Unit Detail")
@export var type: Type = Type.Normal_Tank
@export var color: Colors = Colors.BLUE

@export_group("Pattern Detail")
@export var amount: int = 5
@export var delay_btw_spawns: float = 1
@export var wait_after_pattern_complete: float = 1

@export_group("Loop Detail")
@export_enum("Start", "Stop", "No Loop") var loopings_state: String = "No Loop"
@export_range(0, 5, 1, "or_greater") var times_to_repeat: int = 0
