extends Node
signal game_ended

var base_destroyed: bool = false

var chapter_num: int = 0
var level_num: int = 0

var max_waves: int = 10
var current_wave: int = 0

var base_max_hp: float = 50
var base_hp: float = 50

var map_money: int = 1000

# experimental
var damage_through_mouse: bool = false
var mouse_damage: int = 20


func _ready() -> void:
	Engine.time_scale = 1
