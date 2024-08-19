extends Node2D

@onready var level: Level = $Level

var tower_tiles: TileMapLayer

var previous_selected_tile: Vector2i

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and not event.pressed:
			select_tile(get_global_mouse_position())


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tower_tiles = level.tower_tiles


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func select_tile(m_pos: Vector2):
	if previous_selected_tile:
		tower_tiles.erase_cell(previous_selected_tile)
	
	var tile_cords = tower_tiles.local_to_map(m_pos)
	previous_selected_tile = tile_cords
	
	
	var road_tile_cords = level.road.local_to_map(m_pos)
	var tile_data = level.road.get_cell_tile_data(road_tile_cords)
	
	tower_tiles.set_cell(tile_cords, 1, Vector2i(0, 0)) if not tile_data else tower_tiles.set_cell(tile_cords, 1, Vector2i(1, 0))
