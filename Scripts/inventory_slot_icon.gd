extends Control

@export var frame: Texture2D
@export var item_sprite: Texture2D
@export var amount: int

const TEST_LOOT_ITEM = preload("res://Resources/CustomResources/test_loot_item.tres")

func _ready() -> void:
	%ItemFrame.texture = frame
	%ItemFrame.sprite.texture = item_sprite
	%Amount.text = str(amount)
