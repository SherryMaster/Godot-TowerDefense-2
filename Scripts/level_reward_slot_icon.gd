extends Control

@export var loot_item: LootItem

var frame: Texture2D
var item_sprite: Texture2D
var amount: int

func _ready() -> void:
	var items = GamePlayData.GAME_INVENTORY[(Item.Type.keys()[loot_item.type]).capitalize() + "s"]
	
	frame = GamePlayData.GAME_INVENTORY.Towers[0].item_rarity_frames[loot_item.rarity][0]
	item_sprite = items.filter(func(item): return item.item_name == loot_item[(Item.Type.keys()[loot_item.type]).to_lower()])[0].texture
	amount = loot_item.quantity.x
	
	%ItemFrame.texture = frame
	%ItemFrame.sprite.texture = item_sprite
	%Amount.text = str(amount)
