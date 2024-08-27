extends Button
class_name BuildButton

enum Type {Tile, Tower}

@onready var price_label: Label = $PriceLabel
@onready var amount_label: Label = $AmountLabel
@onready var cancel_button: Button = $CancelButton

var type: Type = Type.Tile
var button_index:int = 0
var item_name: String = ""

const BUILD_BUTTON_TILE_THEME = preload("res://Resources/Themes/BuildBar/Item Buttons/build_button_tile_theme.tres")
const BUILD_BUTTON_TOWER_THEME = preload("res://Resources/Themes/BuildBar/Item Buttons/build_button_tower_theme.tres")
const GAME_INVENTORY = preload("res://Resources/GameData/game_inventory.tres")

# Tile only
var tile_atlas_cords: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refresh_ui()

func refresh_ui():
	if type == Type.Tile:
		theme = BUILD_BUTTON_TILE_THEME
		set_button_icon(GAME_INVENTORY.Tiles[button_index].texture)
		price_label.text = "$ " + str(GAME_INVENTORY.Tiles[button_index].placement_cost)
		amount_label.text = "X " + str(GAME_INVENTORY.Tiles[button_index].in_inventory)
		tile_atlas_cords = GAME_INVENTORY.Tiles[button_index].atlas_cordinates
		if GAME_INVENTORY.Tiles[button_index].in_inventory == 0:
			queue_free()
	else:
		theme = BUILD_BUTTON_TOWER_THEME
		set_button_icon(GAME_INVENTORY.Towers[button_index].texture)
		price_label.text = "$ " + str(GAME_INVENTORY.Towers[button_index].placement_cost)
		amount_label.text = "X " + str(GAME_INVENTORY.Towers[button_index].in_inventory)
		if GAME_INVENTORY.Towers[button_index].in_inventory == 0:
			queue_free()
