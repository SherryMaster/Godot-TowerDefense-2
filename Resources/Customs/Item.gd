extends Resource
class_name Item
enum Rarity {COMMON, UNCOMMON, RARE}
enum Type {TOWER, TILE, MATERIAL}

const COMMON_FRAME = preload("res://Assets/RarityFrames/Common Frame.png")
const COMMON_FRAME_HOVER = preload("res://Assets/RarityFrames/Common Frame Hover.png")
const COMMON_FRAME_PRESSED = preload("res://Assets/RarityFrames/Common Frame Pressed.png")

const RARE_FRAME = preload("res://Assets/RarityFrames/Rare Frame.png")
const RARE_FRAME_HOVER = preload("res://Assets/RarityFrames/Rare Frame Hover.png")
const RARE_FRAME_PRESSED = preload("res://Assets/RarityFrames/Rare Frame Pressed.png")

const UNCOMMON_FRAME = preload("res://Assets/RarityFrames/Uncommon Frame.png")
const UNCOMMON_FRAME_HOVER = preload("res://Assets/RarityFrames/Uncommon Frame Hover.png")
const UNCOMMON_FRAME_PRESSED = preload("res://Assets/RarityFrames/Uncommon Frame Pressed.png")

var item_rarity_frames = {
	Rarity.COMMON: [COMMON_FRAME, COMMON_FRAME_HOVER, COMMON_FRAME_PRESSED],
	Rarity.UNCOMMON: [UNCOMMON_FRAME, UNCOMMON_FRAME_HOVER, UNCOMMON_FRAME_PRESSED],
	Rarity.RARE: [RARE_FRAME, RARE_FRAME_HOVER, RARE_FRAME_PRESSED],
}

@export var item_name: String
@export var texture: Texture2D
@export var rarity: Rarity
@export var type: Type
@export var in_inventory: int
