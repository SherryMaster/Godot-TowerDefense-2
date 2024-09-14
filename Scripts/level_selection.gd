extends Control
signal level_selected(index)

var chapter_num: int = 1

const CHAPTERS_DATA: ChapterResource = preload("res://Resources/GameData/chapters_data.tres")

# Scenes
const LEVEL_BUTTON = preload("res://Scenes/UIScenes/level_button.tscn")
const LEVEL_REWARD_ICON_SLOT = preload("res://Scenes/UIScenes/level_reward_icon_slot.tscn")

# Themes
const LEVEL_BUTTON_COMPLETED = preload("res://Resources/Themes/level_button_completed.tres")
const LEVEL_BUTTON_UNLOCKED = preload("res://Resources/Themes/level_button_unlocked.tres")


@onready var level_container: HFlowContainer = $BG/MarginContainer/Level_Container
@onready var level_detail: LevelDetailScreen = $LevelDetail
@onready var back_button: Button = $BackButton


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
	if not level_detail.visible:
		level_detail.visible = true
	level_detail.level_image.texture = CHAPTERS_DATA.levels[index].level_image
	level_detail.level_name.text = "Level " + str(index + 1)
	
	level_detail.clear_rewards_ui()
	for loot in CHAPTERS_DATA.levels[index].clear_reward.loot_list:
		var new_loot_icon = LEVEL_REWARD_ICON_SLOT.instantiate()
		new_loot_icon.loot_item = loot
		level_detail.rewards.add_child(new_loot_icon)
	
	for connection in level_detail.play.pressed.get_connections():
		level_detail.play.pressed.disconnect(connection["callable"])
	
	level_detail.play.pressed.connect(func(): level_selected.emit(index))
	
	level_detail.animation_player.play("enter")
