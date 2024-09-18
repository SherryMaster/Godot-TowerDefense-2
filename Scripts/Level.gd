extends Node2D
class_name Level

@onready var ground: TileMapLayer = $Map/Ground
@onready var road: TileMapLayer = $Map/Road
@onready var tiles_layer: TileMapLayer = $Map/Tiles
@onready var towers_layer: TileMapLayer = $Map/Towers
@onready var tile_selector: TileMapLayer = $Map/TileSelector

@onready var start: Node2D = $Start
@onready var end: Node2D = $End
@onready var path_points: Node2D = $PathPoints
@onready var units: Node2D = $Units
@onready var towers: Node2D = $Towers

@onready var game_camera: GameCamera = $GameCamera


func get_paths() -> Array[Node2D]:
	var pos: Array[Node2D] = []
	for point in path_points.get_children():
		pos.append(point)
	
	pos.append(end)
	
	return pos

func get_reverse_paths() -> Array[Node2D]:
	var pos: Array[Node2D] = []
	for point in path_points.get_children():
		pos.append(point)
	
	pos.reverse()
	pos.append(start)
	
	return pos
