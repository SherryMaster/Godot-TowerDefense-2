extends Control
signal level_selected(index)

var chapter_num: int = 1

const CHAPTERS_DATA: ChapterResource = preload("res://Resources/GameData/chapters_data.tres")
const LEVEL_BUTTON = preload("res://Scenes/UIScenes/level_button.tscn")

# Themes
const LEVEL_BUTTON_COMPLETED = preload("res://Resources/Themes/level_button_completed.tres")
const LEVEL_BUTTON_UNLOCKED = preload("res://Resources/Themes/level_button_unlocked.tres")


@onready var level_container: HFlowContainer = $BG/MarginContainer/Level_Container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var levels: int = CHAPTERS_DATA.levels.size()
	for i in range(levels):
		var button = LEVEL_BUTTON.instantiate()
		button.level_index = i
		button.pressed.connect(on_button_press.bind(i))
		if CHAPTERS_DATA.levels[i].level_completed:
			button.theme = LEVEL_BUTTON_COMPLETED
		elif CHAPTERS_DATA.levels[i].level_unlocked:
			button.theme = LEVEL_BUTTON_UNLOCKED
		else:
			button.disabled = true
		level_container.add_child(button)

func on_button_press(index: int):
	level_selected.emit(index)
