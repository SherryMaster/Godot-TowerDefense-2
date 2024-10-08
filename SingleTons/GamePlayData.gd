extends Node
signal game_ended
signal wave_started
signal wave_ended

var base_destroyed: bool = false
var game_paused: bool = false

var chapter_num: int = 0
var level_num: int = 0

var max_waves: int = 10
var current_wave: int = 0

var base_max_hp: float = 50
var base_hp: float = 50

var map_money: int = 1000

var Session_Inventory = {}

const GAME_INVENTORY = preload("res://Resources/GameData/game_inventory.tres")
#var GAME_INVENTORY: Inventory
# experimental
var damage_through_mouse: bool = false
var mouse_damage: int = 20

func _ready() -> void:
	#GAME_INVENTORY = preload("res://Resources/GameData/game_inventory.tres")
	set_game_speed(1)

func load_session_inventory():
	Session_Inventory["Tiles"] = []
	Session_Inventory["Towers"] = []
	
	for tile in GAME_INVENTORY.Tiles:
		Session_Inventory["Tiles"].append({
			"quantity": tile.quantity,
			"placement_cost": tile.placement_cost,
		})
	
	for tower in GAME_INVENTORY.Towers:
		Session_Inventory.Towers.append({
			"quantity": tower.quantity,
			"placement_cost": tower.placement_cost,
		})

func set_game_speed(scale: float):
	Engine.time_scale = scale
