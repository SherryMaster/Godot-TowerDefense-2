extends Resource
class_name LootItem

@export var type: Item.Type
@export var rarity: Item.Rarity
@export_range(1, 500, 1, "or_greater") var one_in_chance: int = 1
@export var quantity: Vector2i = Vector2i(1, 1)
@export var granteed: bool

@export_group("tower")
@export var tower: TowerItem.Towers = 0

@export_group("tile")
@export var tile: TileItem.Tiles = 0

@export_group("material")
@export var material: MaterialItem.Materials = 0

func claim_loot():
	if type == Item.Type.TOWER:
		var filtered_towers = GamePlayData.GAME_INVENTORY.Towers.filter(func(the_tower): return (the_tower.item_name == tower and the_tower.rarity == rarity))
		for tower in filtered_towers as Array[TowerItem]:
			var tower_index = GamePlayData.GAME_INVENTORY.Towers.find(tower)
			GamePlayData.GAME_INVENTORY.Towers[tower_index].quantity += get_loot_amount(quantity)
	
	if type == Item.Type.TILE:
		var filtered_tiles = GamePlayData.GAME_INVENTORY.Tiles.filter(func(the_tile): return (the_tile.item_name == tile and the_tile.rarity == rarity))
		for til in filtered_tiles as Array[TileItem]:
			var tile_index = GamePlayData.GAME_INVENTORY.Tiles.find(til)
			GamePlayData.GAME_INVENTORY.Tiles[tile_index].quantity += get_loot_amount(quantity)
	
	if type == Item.Type.MATERIAL:
		var filtered_materials = GamePlayData.GAME_INVENTORY.Materials.filter(func(the_material): return (the_material.item_name == material and the_material.rarity == rarity))
		for mat in filtered_materials as Array[MaterialItem]:
			var mat_index = GamePlayData.GAME_INVENTORY.Materials.find(mat)
			GamePlayData.GAME_INVENTORY.Materials[mat_index].quantity += get_loot_amount(quantity)
	
	
	ResourceSaver.save(GamePlayData.GAME_INVENTORY)

func get_loot_amount(quantity: Vector2i):
	return randi_range(quantity.x, quantity.y)
