extends Node2D
class_name GameScene

var current_wave: int = 0
var level_num: int = 0
var chapter_number: int = 0

@onready var level: Level = $Level
const CHAPTERS_DATA = preload("res://Resources/GameData/chapters_data.tres")
var tile_selection_layer: TileMapLayer

var previous_selected_tile: Vector2i

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == 1 and not event.pressed:
			#select_tile(get_global_mouse_position())


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_selection_layer = level.tile_selector


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	select_tile(get_global_mouse_position())

func select_tile(m_pos: Vector2):
	if previous_selected_tile:
		tile_selection_layer.erase_cell(previous_selected_tile)
	
	var tile_cords = tile_selection_layer.local_to_map(m_pos)
	previous_selected_tile = tile_cords
	
	
	var road_tile_cords = level.road.local_to_map(m_pos)
	var tile_data = level.road.get_cell_tile_data(road_tile_cords)
	
	tile_selection_layer.set_cell(tile_cords, 1, Vector2i(0, 0)) if not tile_data else tile_selection_layer.set_cell(tile_cords, 1, Vector2i(1, 0))


func spawn_wave(wane_num: int):
	pass
