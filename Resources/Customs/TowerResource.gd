extends Resource
class_name TowerResource

@export_enum("Scout Tower") var tower_name: String = "Scout Tower"
@export var tower_scene: PackedScene
@export var texture: Texture2D
@export var in_inventory: int = 0
@export var placement_cost: int = 100
