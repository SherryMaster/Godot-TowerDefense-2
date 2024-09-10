extends Resource
class_name LootList

@export var max_obtain_loot: int = 1
@export var one_time_obtainable: bool = false
@export var obtainable: bool = true
@export var sorted = false
@export var loot_list: Array[LootItem]

var obtained_amount = 0

func obtain_loot():
	if not sorted:
		loot_list.sort_custom(sort_loot)
		sorted = true
	
	while(true):
		for loot in loot_list:
			if randi_range(1, loot.one_in_chance) == 1:
				#loot.claim_loot()
				print(TowerItem.Towers.keys()[loot.tower] if loot.type == Item.Type.TOWER else TileItem.Tiles.keys()[loot.tile] if loot.type == Item.Type.TILE else MaterialItem.Materials.keys()[loot.material], " - ", Item.Rarity.keys()[loot.rarity], " - ", loot.get_loot_amount(loot.quantity))
				obtained_amount += 1
				break
		
		if obtained_amount >= max_obtain_loot:
			break
	
	if one_time_obtainable:
		obtainable = false
	obtained_amount = 0
	
	ResourceSaver.save(self)

func sort_loot(item1: LootItem, item2: LootItem):
	if item1.one_in_chance > item2.one_in_chance:
		return true
	return false
