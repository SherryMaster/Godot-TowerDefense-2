extends Node
class_name SceneHandler

const MAIN_MENU = preload("res://Scenes/UIScenes/main_menu.tscn")
const GAME_SCENE = preload("res://Scenes/MainScenes/game_scene.tscn")
const LEVEL_SELECTION = preload("res://Scenes/UIScenes/level_selection.tscn")
const WIN_STAT_SCREEN = preload("res://Scenes/UIScenes/win_stat_screen.tscn")
const INVENTORY_DISPLAY = preload("res://Scenes/UIScenes/inventory_display.tscn")


const CHAPTERS_DATA = preload("res://Resources/GameData/chapters_data.tres")


var game_scene: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_main_menu()

func load_main_menu():
	clear_scene()
	var main_menu: Control = MAIN_MENU.instantiate()
	main_menu.get_node("MC/VBC/HBC/VBC/PlayButton").pressed.connect(load_level_selection_scene.bind(1))
	main_menu.get_node("MC/VBC/HBC/VBC/Inventory").pressed.connect(load_inventory_scene)
	add_child(main_menu)
	await main_menu.ready

func load_game_scene(level_num: int):
	clear_scene()
	
	GamePlayData.level_num = level_num
	GamePlayData.load_session_inventory()
	GamePlayData.map_money = CHAPTERS_DATA.levels[level_num].starting_money
	GamePlayData.base_max_hp = CHAPTERS_DATA.levels[level_num].starting_base_hp
	GamePlayData.base_hp = GamePlayData.base_max_hp
	GamePlayData.game_ended.connect(on_game_ended)
	GamePlayData.base_destroyed = false
	
	game_scene= GAME_SCENE.instantiate()
	game_scene.connect("game_over", load_main_menu)
	
	var level_scene: Level = CHAPTERS_DATA.levels[level_num].level_scene.instantiate()
	game_scene.add_child(level_scene)
	game_scene.move_child(level_scene, 0)
	add_child(game_scene)
	
	Resource

func load_level_selection_scene(ch_num: int):
	clear_scene()
	var level_selection_scene = LEVEL_SELECTION.instantiate()
	add_child(level_selection_scene)
	level_selection_scene.chapter_num = ch_num
	level_selection_scene.level_selected.connect(load_game_scene)
	level_selection_scene.back_button.pressed.connect(load_main_menu)

func load_inventory_scene():
	clear_scene()
	var inventory = INVENTORY_DISPLAY.instantiate()
	inventory.get_node("BackButton").pressed.connect(load_main_menu)
	add_child(inventory)

func on_game_ended():
	var stat_screen = WIN_STAT_SCREEN.instantiate()
	stat_screen.back_button_press.connect(load_level_selection_scene.bind(GamePlayData.chapter_num))
	stat_screen.restart_button_press.connect(load_game_scene.bind(GamePlayData.level_num))
	if not GamePlayData.base_destroyed:
		CHAPTERS_DATA.levels[GamePlayData.level_num].level_completed = true
		if GamePlayData.level_num < CHAPTERS_DATA.levels.size() - 1:
			CHAPTERS_DATA.levels[GamePlayData.level_num + 1].level_unlocked = true
		stat_screen.status_text = "You Win"
		
		ResourceSaver.save(CHAPTERS_DATA)
		
	else:
		stat_screen.status_text = "You Loose"
	game_scene.hud.add_child(stat_screen)
	

func clear_scene():
	if get_child_count() > 0:
		get_child(0).queue_free()

	
