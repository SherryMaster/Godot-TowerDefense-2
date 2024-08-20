extends Node2D
class_name Level

@onready var ground: TileMapLayer = $Map/Ground
@onready var road: TileMapLayer = $Map/Road
@onready var tower_tiles: TileMapLayer = $Map/TowerTiles
@onready var tile_selector: TileMapLayer = $Map/TileSelector

@onready var start: Node2D = $Start
@onready var end: Node2D = $End

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
