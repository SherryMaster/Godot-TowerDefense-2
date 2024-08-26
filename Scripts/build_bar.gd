extends Control
class_name BuildBar

@onready var tile_buttons: HBoxContainer = $TilePanel/MarginContainer/ScrollContainer/TileButtons
@onready var tower_buttons: HBoxContainer = $TowerPanel/MarginContainer/ScrollContainer/TowerButtons

func _on_trigger_tile_panel_pressed() -> void:
	$TilePanel.visible = true
	$TowerPanel.visible = false

func _on_trigger_tower_panel_pressed() -> void:
	$TilePanel.visible = false
	$TowerPanel.visible = true
