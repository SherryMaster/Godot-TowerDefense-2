extends Node2D
class_name GameScene

const CHAPTERS_DATA = preload("res://Resources/GameData/chapters_data.tres")

var current_wave: int = 0
var max_waves: int = 0
var level_num: int = 1
var chapter_number: int = 1

var enemy_remaining: int = 0
var spawning_enemies: bool = false

@onready var level: Level = $Level
@onready var enemy_spawner: Timer = $EnemySpawner

var tile_selection_layer: TileMapLayer
var previous_selected_tile: Vector2i

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == 1 and not event.pressed:
			#select_tile(get_global_mouse_position())


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 2
	tile_selection_layer = level.tile_selector
	max_waves = CHAPTERS_DATA.levels[level_num - 1].waves.size() - 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	select_tile(get_global_mouse_position())
	if enemy_remaining == 0:
		if current_wave <= max_waves:
			spawn_wave()
		else: 
			return
		current_wave += 1
		
	

func select_tile(m_pos: Vector2):
	if previous_selected_tile:
		tile_selection_layer.erase_cell(previous_selected_tile)
	
	var tile_cords = tile_selection_layer.local_to_map(m_pos)
	previous_selected_tile = tile_cords
	
	
	var road_tile_cords = level.road.local_to_map(m_pos)
	var tile_data = level.road.get_cell_tile_data(road_tile_cords)
	
	tile_selection_layer.set_cell(tile_cords, 1, Vector2i(0, 0)) if not tile_data else tile_selection_layer.set_cell(tile_cords, 1, Vector2i(1, 0))


func spawn_wave():
	spawning_enemies = true
	var loop_start_index: int = -1
	var loop_end_index: int = -1
	var loop_left: int = 0
	
	var loop_detected: bool = false
	var loop_started: bool = false
	
	var wave: Array[WavePartResource] = CHAPTERS_DATA.levels[level_num - 1].waves[current_wave].wave_parts
	var total_parts: int = wave.size()
	var part_index: int = 0
	while(true):
		
		var part = wave[part_index]
		var type: String = part.type
		if part.loopings_state == "Start" and not loop_detected:
			loop_start_index = part_index
			loop_left = part.times_to_repeat
			print("Loop Detected!\tAt Wave: ", part_index,"\tTimes to repeat: ", loop_left)
			loop_detected = true
			
		if part.loopings_state == "Stop" and loop_detected:
			loop_started = true
			loop_end_index = part_index
			loop_left -= 1
			if not loop_left:
				loop_detected = false
				loop_started = false
			print("Loop Cycle Detected!\tAt Wave: ", part_index, "\tLoops Left: ", loop_left)
			if not loop_started:
				print("End of Loop!")
		
		for i in range(part.amount):
			var tank = load("res://Scenes/Entities/Tanks/" + type.to_lower() + ".tscn").instantiate() as Tank
			tank.color = part.colors[part.color]
			tank.max_hp = GameData.CLASSIC_TANK_STATS[part.color]["Hp"] * CHAPTERS_DATA.levels[level_num - 1].waves[current_wave].hp_scale
			tank.speed = GameData.CLASSIC_TANK_STATS[part.color]["Speed"]
			tank.money_on_death = GameData.CLASSIC_TANK_STATS[part.color]["Coins on Death"]
			tank.main_target = level.end
			tank.global_position = level.start.global_position
			tank.destroyed.connect(update_num_of_enemies.bind(-1))
			level.units.add_child(tank)
			update_num_of_enemies(1)
			enemy_spawner.start(part.delay_btw_spawns)
			await enemy_spawner.timeout
		
		enemy_spawner.start(part.wait_after_pattern_complete)
		await enemy_spawner.timeout
		
		part_index += 1

		if loop_left > 0 and loop_started and part_index > loop_end_index:
			part_index = loop_start_index
		
		if part_index >= total_parts:
			print("End of Waves")
			break
	
	spawning_enemies = false

func update_num_of_enemies(amount):
	enemy_remaining = enemy_remaining + amount
