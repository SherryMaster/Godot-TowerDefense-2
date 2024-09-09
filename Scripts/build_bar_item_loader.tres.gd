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
			if GamePlayData.Session_Inventory.Tiles[i].quantity:
				var build_button = BUILD_BUTTON.instantiate() as BuildButton
				build_button.button_index = i
				build_button.type = type_of_items
				build_button.item_name = GamePlayData.GAME_INVENTORY.Tiles[i].item_name
				add_child(build_button)
	
	if type_of_items == BuildButton.Type.Tower:
		total_items = GamePlayData.Session_Inventory.Towers.size()
		for i in range(total_items):
			if GamePlayData.Session_Inventory.Towers[i].quantity:
				var build_button = BUILD_BUTTON.instantiate() as BuildButton
				build_button.button_index = i
				build_button.type = type_of_items
				build_button.item_name = GamePlayData.GAME_INVENTORY.Towers[i].item_name
				add_child(build_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
