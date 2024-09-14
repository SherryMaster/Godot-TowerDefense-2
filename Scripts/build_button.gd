extends TextureButton
class_name BuildButton

enum Type {Tile, Tower}

@onready var price_label: Label = $PriceLabel
@onready var amount_label: Label = $AmountLabel
@onready var cancel_button: Button = $CancelButton
@onready var item_icon: TextureRect = $ItemIcon

var type: Type = Type.Tile
var button_index:int = 0
var item_name: TowerItem.Type


# Tile only
var tile_atlas_cords: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refresh_ui()

func refresh_ui():
	if type == Type.Tile:
		texture_normal = GamePlayData.GAME_INVENTORY.Tiles[button_index].item_rarity_frames[GamePlayData.GAME_INVENTORY.Tiles[button_index].rarity][0]
		texture_hover = GamePlayData.GAME_INVENTORY.Tiles[button_index].item_rarity_frames[GamePlayData.GAME_INVENTORY.Tiles[button_index].rarity][1]
		texture_pressed = GamePlayData.GAME_INVENTORY.Tiles[button_index].item_rarity_frames[GamePlayData.GAME_INVENTORY.Tiles[button_index].rarity][2]
		item_icon.texture = GamePlayData.GAME_INVENTORY.Tiles[button_index].texture
		price_label.text = "$ " + str(GamePlayData.Session_Inventory.Tiles[button_index].placement_cost)
		amount_label.text = str(GamePlayData.Session_Inventory.Tiles[button_index].quantity)
		tile_atlas_cords = GamePlayData.GAME_INVENTORY.Tiles[button_index].atlas_cordinates
		if GamePlayData.Session_Inventory.Tiles[button_index].quantity == 0:
			queue_free()
	else:
		texture_normal = GamePlayData.GAME_INVENTORY.Towers[button_index].item_rarity_frames[GamePlayData.GAME_INVENTORY.Towers[button_index].rarity][0]
		texture_hover = GamePlayData.GAME_INVENTORY.Towers[button_index].item_rarity_frames[GamePlayData.GAME_INVENTORY.Towers[button_index].rarity][1]
		texture_pressed = GamePlayData.GAME_INVENTORY.Towers[button_index].item_rarity_frames[GamePlayData.GAME_INVENTORY.Towers[button_index].rarity][2]
		item_icon.texture = GamePlayData.GAME_INVENTORY.Towers[button_index].texture
		price_label.text = "$ " + str(GamePlayData.Session_Inventory.Towers[button_index].placement_cost)
		amount_label.text = str(GamePlayData.Session_Inventory.Towers[button_index].quantity)
		if GamePlayData.Session_Inventory.Towers[button_index].quantity == 0:
			queue_free()
