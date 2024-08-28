extends HBoxContainer
class_name BuildButtonsContainer

@export var type_of_items: BuildButton.Type

const BUILD_BUTTON = preload("res://Scenes/UIScenes/build_button.tscn")


var total_items: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type_of_items == BuildButton.Type.Tile:
		total_items = GamePlayData.Session_Inventory.Tiles.size()
		for i in range(total_items):
			if GamePlayData.Session_Inventory.Tiles[i].in_inventory:
				var build_button = BUILD_BUTTON.instantiate() as BuildButton
				var tiles = GamePlayData.Session_Inventory.Tiles
				build_button.button_index = i
				build_button.type = type_of_items
				build_button.item_name = GamePlayData.Session_Inventory.Tiles[i].tile_name
				add_child(build_button)
	
	if type_of_items == BuildButton.Type.Tower:
		total_items = GamePlayData.Session_Inventory.Towers.size()
		for i in range(total_items):
			if GamePlayData.Session_Inventory.Towers[i].in_inventory:
				var build_button = BUILD_BUTTON.instantiate() as BuildButton
				build_button.button_index = i
				build_button.type = type_of_items
				build_button.item_name = GamePlayData.Session_Inventory.Towers[i].tower_name
				add_child(build_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
