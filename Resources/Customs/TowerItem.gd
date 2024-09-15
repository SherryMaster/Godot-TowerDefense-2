extends Item
class_name TowerItem
enum Towers{Gun_Tower, Rocket_Tower, Shotgun_Tower}

@export var item_name: Towers = Towers.Gun_Tower
@export var tower_scene: PackedScene
@export var placement_cost: int = 100

var type: Type = Type.TOWER
