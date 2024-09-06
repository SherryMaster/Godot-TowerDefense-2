extends Node2D
class_name Level

@onready var ground: TileMapLayer = $Map/Ground
@onready var road: TileMapLayer = $Map/Road
@onready var tiles_layer: TileMapLayer = $Map/Tiles
@onready var towers_layer: TileMapLayer = $Map/Towers
@onready var tile_selector: TileMapLayer = $Map/TileSelector

@onready var start: Node2D = $Start
@onready var end: Node2D = $End
@onready var units: Node2D = $Units
@onready var enemy: Node2D = $Units/Enemy
@onready var ally: Node2D = $Units/Ally
@onready var towers: Node2D = $Towers

@onready var game_camera: GameCamera = $GameCamera
