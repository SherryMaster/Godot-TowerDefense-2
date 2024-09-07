extends Item
class_name TileItem
enum Tiles{Classic_Tile}

@export var item_name: Tiles = Tiles.Classic_Tile
@export var placement_cost: int = 20
@export var atlas_cordinates: Vector2i

var type: Type = Type.TILE
