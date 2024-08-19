extends Node
class_name StatsComponent

var hp: float = 100
@export var max_hp: float = 100
@export var speed: float = 50
@export_range(0, 1) var speed_power: float = 1
@export_range(0, 0.1) var break_power: float = 0.1
@export_range(0, 0.1) var drag_factor: float = 0.1
