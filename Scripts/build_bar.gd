extends Control
class_name BuildBar

@onready var tile_buttons: HBoxContainer = $TilePanel/MarginContainer/ScrollContainer/TileButtons
@onready var tower_buttons: HBoxContainer = $TowerPanel/MarginContainer/ScrollContainer/TowerButtons
@onready var panel_toggle: Button = $Panel_Toggle

func _on_trigger_tile_panel_pressed() -> void:
	if not panel_toggle.is_pressed():
		panel_toggle.set_pressed(true)
	$TilePanel.visible = true
	$TowerPanel.visible = false

func _on_trigger_tower_panel_pressed() -> void:
	if not panel_toggle.is_pressed():
		panel_toggle.set_pressed(true)
	$TilePanel.visible = false
	$TowerPanel.visible = true
