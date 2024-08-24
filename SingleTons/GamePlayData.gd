extends Node
signal game_ended

var base_destroyed: bool = false

var max_waves: int = 10
var current_wave: int = 0

var base_max_hp: float = 50
var base_hp: float = 50

var map_money: int = 1000

# experimental
var damage_through_mouse: bool = true
var mouse_damage: int = 20


func _ready() -> void:
	Engine.time_scale = 1
