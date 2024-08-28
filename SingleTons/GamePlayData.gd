extends Node
signal game_ended

var base_destroyed: bool = false

var chapter_num: int = 0
var level_num: int = 0

var max_waves: int = 10
var current_wave: int = 0

var base_max_hp: float = 50
var base_hp: float = 50

var map_money: int = 1000

var Session_Inventory = {}
const GAME_INVENTORY = preload("res://Resources/GameData/game_inventory.tres")
# experimental
var damage_through_mouse: bool = false
var mouse_damage: int = 20


func _ready() -> void:
	Engine.time_scale = 1

func load_session_inventory():
	Session_Inventory["Tiles"] = []
	Session_Inventory["Towers"] = []
	
	for tile in GAME_INVENTORY.Tiles:
		Session_Inventory["Tiles"].append({
			"tile_name": tile.tile_name,
			"texture": tile.texture,
			"in_inventory": tile.in_inventory,
			"placement_cost": tile.placement_cost,
			"atlas_cordinates": tile.atlas_cordinates
		})
	
	for tower in GAME_INVENTORY.Towers:
		Session_Inventory.Towers.append({
			"tower_name": tower.tower_name,
			"tower_scene": tower.tower_scene,
			"texture": tower.texture,
			"in_inventory": tower.in_inventory,
			"placement_cost": tower.placement_cost,
		})
