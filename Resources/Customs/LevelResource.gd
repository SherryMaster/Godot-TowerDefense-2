@icon("res://Assets/CustomNodeIcons/levels.png")
extends Resource
class_name LevelResource

@export var starting_money: int = 1000
@export var starting_base_hp: float = 100
@export var level_image: Texture2D
@export var level_completed: bool = false
@export var level_unlocked: bool = false
@export var level_scene: PackedScene
@export var waves: Array[EnemyWave]
@export var clear_reward: LootList
@export var win_loot: LootList
