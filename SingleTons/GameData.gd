extends Node

var TankStats = {
	WavePart.Type.Normal_Tank:{
		"Hp": 25,
		"Speed": 50,
		"Coins on Death": 5
	}
}

var Hp_Scales_by_Color = {
	WavePart.Colors.BLUE: 1,
	WavePart.Colors.RED: 3,
	WavePart.Colors.GREEN: 9,
	WavePart.Colors.YELLOW: 27,
	WavePart.Colors.PINK: 81,
	WavePart.Colors.ORANGE: 243,
	WavePart.Colors.PURPLE: 729,
	WavePart.Colors.CYAN: 2187,
	WavePart.Colors.MAGENTA: 6561,
	WavePart.Colors.LIME: 19683,
	WavePart.Colors.TEAL: 59049,
	WavePart.Colors.VIOLET: 177147,
	WavePart.Colors.INDIGO: 531441,
	WavePart.Colors.TURQUOISE: 1594323,
	WavePart.Colors.SCARLET: 4782969,
	WavePart.Colors.AMBER: 14348907,
	WavePart.Colors.CRIMSON: 43046721,
	WavePart.Colors.EMERALD: 129140163,
	WavePart.Colors.SAPPHIRE: 387420489,
	WavePart.Colors.RUBY: 1162261467,
	WavePart.Colors.CORAL: 3486784401,
	WavePart.Colors.AQUA: 10460353203,
	WavePart.Colors.LAVENDER: 31381059609,
	WavePart.Colors.MAROON: 94143178827,
	WavePart.Colors.OLIVE: 282429536481,
	WavePart.Colors.GOLD: 847288609443,
	WavePart.Colors.SILVER: 2541865828329,
	WavePart.Colors.BRONZE: 7625597484987,
	WavePart.Colors.COPPER: 22876792454961,
	WavePart.Colors.PLATINUM: 68630377364883,
	WavePart.Colors.TITANIUM: 205891132094649,
	WavePart.Colors.OBSIDIAN: 617673396283947,
	WavePart.Colors.ONYX: 1853020188851841,
	WavePart.Colors.IVORY: 5559060566555523,
	WavePart.Colors.CHARCOAL: 16677181699666569,
	WavePart.Colors.GRAPHITE: 50031545098999707,
	WavePart.Colors.STEEL: 150094635296999121,
	WavePart.Colors.QUARTZ: 450283905890997363,
	WavePart.Colors.DIAMOND: 1350851717672992089,
	WavePart.Colors.PEARL: 4052555153018976267
}

var CoinDrop_Scales_by_Color = {
	WavePart.Colors.BLUE: 1,
	WavePart.Colors.RED: 3,
	WavePart.Colors.GREEN: 9,
	WavePart.Colors.YELLOW: 27,
	WavePart.Colors.PINK: 81,
	WavePart.Colors.ORANGE: 243,
	WavePart.Colors.PURPLE: 729,
	WavePart.Colors.CYAN: 2187,
	WavePart.Colors.MAGENTA: 6561,
	WavePart.Colors.LIME: 19683,
	WavePart.Colors.TEAL: 59049,
	WavePart.Colors.VIOLET: 177147,
	WavePart.Colors.INDIGO: 531441,
	WavePart.Colors.TURQUOISE: 1594323,
	WavePart.Colors.SCARLET: 4782969,
	WavePart.Colors.AMBER: 14348907,
	WavePart.Colors.CRIMSON: 43046721,
	WavePart.Colors.EMERALD: 129140163,
	WavePart.Colors.SAPPHIRE: 387420489,
	WavePart.Colors.RUBY: 1162261467,
	WavePart.Colors.CORAL: 3486784401,
	WavePart.Colors.AQUA: 10460353203,
	WavePart.Colors.LAVENDER: 31381059609,
	WavePart.Colors.MAROON: 94143178827,
	WavePart.Colors.OLIVE: 282429536481,
	WavePart.Colors.GOLD: 847288609443,
	WavePart.Colors.SILVER: 2541865828329,
	WavePart.Colors.BRONZE: 7625597484987,
	WavePart.Colors.COPPER: 22876792454961,
	WavePart.Colors.PLATINUM: 68630377364883,
	WavePart.Colors.TITANIUM: 205891132094649,
	WavePart.Colors.OBSIDIAN: 617673396283947,
	WavePart.Colors.ONYX: 1853020188851841,
	WavePart.Colors.IVORY: 5559060566555523,
	WavePart.Colors.CHARCOAL: 16677181699666569,
	WavePart.Colors.GRAPHITE: 50031545098999707,
	WavePart.Colors.STEEL: 150094635296999121,
	WavePart.Colors.QUARTZ: 450283905890997363,
	WavePart.Colors.DIAMOND: 1350851717672992089,
	WavePart.Colors.PEARL: 4052555153018976267
}

const TEST_LOOT = preload("res://Resources/CustomResources/TestLoot.tres")

func _ready() -> void:
	print(get_tree().get_root().get_children()[-1])
	TEST_LOOT.obtain_loot()
