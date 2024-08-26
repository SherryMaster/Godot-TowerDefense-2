extends HBoxContainer

@export var type_of_items: BuildButton.Type

const GAME_INVENTORY = preload("res://Resources/GameData/game_inventory.tres")
const BUILD_BUTTON = preload("res://Scenes/UIScenes/build_button.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var build_button = BUILD_BUTTON.instantiate() as BuildButton
	if type_of_items == BuildButton.Type.Tile:
		var tiles = GAME_INVENTORY.Tiles
		for tile in tiles:
			build_button.button_index = tiles.find(tile)
			build_button.type = type_of_items
	
	if type_of_items == BuildButton.Type.Tower:
		var towers = GAME_INVENTORY.Towers
		for tower in towers:
			build_button.button_index = towers.find(tower)
			build_button.type = type_of_items
	add_child(build_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
