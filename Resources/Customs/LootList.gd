extends Resource
class_name LootList

@export var max_obtain_loot: int = 1
@export var one_time_obtainable: bool = false
@export var obtain_all_items: bool = false
@export var obtainable: bool = true
@export var sorted = false
@export var loot_list: Array[LootItem]

@export_group("Currencies")
@export var Coins: int
@export var Gold: int
@export var Gems: int

var obtained_amount = 0

func obtain_loot():
	if not sorted:
		loot_list.sort_custom(sort_loot)
		sorted = true
	
	if obtain_all_items:
		for loot in loot_list:
			loot.claim_loot()
	else:
		while(true):
			for loot in loot_list:
				if randi_range(1, loot.one_in_chance) == 1:
					loot.claim_loot()
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
