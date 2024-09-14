extends Resource
class_name LootItem

signal obtained_item(item_name: String, rarity: Item.Rarity, texture: Texture2D)

@export var type: Item.Type
@export var rarity: Item.Rarity
@export_range(1, 500, 1, "or_greater") var one_in_chance: int = 1
@export var quantity: Vector2i = Vector2i(1, 1)
@export var granteed: bool
@export var random: bool

@export_group("tower")
@export var tower: TowerItem.Towers = 0

@export_group("tile")
@export var tile: TileItem.Tiles = 0

@export_group("material")
@export var material: MaterialItem.Materials = 0

func claim_loot():
	var amount: int = randi_range(quantity.x, quantity.y)
	if type == Item.Type.TOWER:
		var filtered_towers = GamePlayData.GAME_INVENTORY.Towers.filter(func(the_tower): return (the_tower.rarity == rarity and (the_tower.item_name == tower if not random else 1)))
		var selected_tower: TowerItem = filtered_towers.pick_random()
		var tower_index = GamePlayData.GAME_INVENTORY.Towers.find(selected_tower)
		#GamePlayData.GAME_INVENTORY.Towers[tower_index].quantity += get_loot_amount(quantity)
		print("Tower: ", TowerItem.Towers.keys()[selected_tower.item_name], "\tRarity: ", Item.Rarity.keys()[rarity], "\tAmount: ", amount)
	
	if type == Item.Type.TILE:
		var filtered_tiles = GamePlayData.GAME_INVENTORY.Tiles.filter(func(the_tile): return (the_tile.rarity == rarity and (the_tile.item_name == tile if not random else 1)))
		var til: TileItem = filtered_tiles.pick_random()
		var tile_index = GamePlayData.GAME_INVENTORY.Tiles.find(til)
		#GamePlayData.GAME_INVENTORY.Tiles[tile_index].quantity += get_loot_amount(quantity)
		print("Tile: ", TileItem.Tiles.keys()[til.item_name], "\tRarity: ", Item.Rarity.keys()[rarity], "\tAmount: ", amount)
		
	if type == Item.Type.MATERIAL:
		var filtered_materials = GamePlayData.GAME_INVENTORY.Materials.filter(func(the_material): return (the_material.rarity == rarity and (the_material.item_name == material if not random else 1)))
		var mat: MaterialItem = filtered_materials.pick_random()
		var mat_index = GamePlayData.GAME_INVENTORY.Materials.find(mat)
		#GamePlayData.GAME_INVENTORY.Materials[mat_index].quantity += get_loot_amount(quantity)
		print("Material: ", MaterialItem.Materials.keys()[mat.item_name], "\tRarity: ", Item.Rarity.keys()[rarity], "\tAmount: ", amount)
	
	ResourceSaver.save(GamePlayData.GAME_INVENTORY)

func get_loot_amount(quantity: Vector2i):
	return randi_range(quantity.x, quantity.y)
