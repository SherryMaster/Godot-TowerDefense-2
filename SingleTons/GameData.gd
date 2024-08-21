extends Node

var CLASSIC_TANK_STATS = {
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
	},
	"Yellow": {
		"Hp": 405,
		"Speed": 50,
		"Coins on Death": 135,
	},
	"Pink":{
		"Hp": 1215,
		"Speed": 50,
		"Coins on Death": 405,
	}
}

var CHAPTERS_DATA: ChapterResource = preload("res://Resources/GameData/chapters_data.tres")

var selected_chapter = 0
var selected_level = 0
var current_wave

func _ready() -> void:
	for lvl in CHAPTERS_DATA.levels:
		var level_index = CHAPTERS_DATA.levels.find(lvl)
		var level = CHAPTERS_DATA.levels[level_index]
		for wve in level.waves:
			var wave_index = level.waves.find(wve)
			var wave = level.waves[wave_index]
			for prt in wave.wave_parts:
				var wave_part_index = wave.wave_parts.find(prt)
				var wave_part = wave.wave_parts[wave_part_index] as WavePartResource
