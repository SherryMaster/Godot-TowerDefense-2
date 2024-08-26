extends Resource
class_name TowerTileResource


@export_enum("Basic Tile") var tile_name: String = "Basic Tile"
@export var texture: Texture2D
@export var in_inventory: int = 0
@export var placement_cost: int = 20
@export var atlas_cordinates: Vector2i
