extends HBoxContainer

@export var type_of_items: BuildButton.Type

const GAME_INVENTORY = preload("res://Resources/GameData/game_inventory.tres")
const BUILD_BUTTON = preload("res://Scenes/UIScenes/build_button.tscn")

var total_items: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type_of_items == BuildButton.Type.Tile:
		total_items = GAME_INVENTORY.Tiles.size()
		for i in range(total_items):
			var build_button = BUILD_BUTTON.instantiate() as BuildButton
			var tiles = GAME_INVENTORY.Tiles
			for tile in tiles:
				build_button.button_index = i
				build_button.type = type_of_items
				build_button.item_name = tile.tile_name
			add_child(build_button)
	
	if type_of_items == BuildButton.Type.Tower:
		total_items = GAME_INVENTORY.Towers.size()
		for i in range(total_items):
			var build_button = BUILD_BUTTON.instantiate() as BuildButton
			var towers = GAME_INVENTORY.Towers
			for tower in towers:
				build_button.button_index = towers.find(tower)
				build_button.type = type_of_items
				build_button.item_name = tower.tower_name
			add_child(build_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
