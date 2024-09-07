extends Item
class_name TowerItem
enum Towers{Scout_Tower}

@export var item_name: Towers = Towers.Scout_Tower
@export var tower_scene: PackedScene
@export var placement_cost: int = 100

var type: Type = Type.TOWER
