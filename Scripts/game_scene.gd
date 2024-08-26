extends Node2D
class_name GameScene

const CHAPTERS_DATA = preload("res://Resources/GameData/chapters_data.tres")


@onready var level: Level = $Level
@onready var enemy_spawner: Timer = $EnemySpawner

@onready var build_bar: Control = $UI/BuildBar


var level_num: int = 1
var chapter_number: int = 1

var enemy_remaining: int = 0


var spawning_enemies: bool = false
var waves_finished: bool = false
var game_finished: bool = false

var tile_selection_layer: TileMapLayer
var previous_selected_tile: Vector2i

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == 1 and not event.pressed:
			#select_tile(get_global_mouse_position())


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_selection_layer = level.tile_selector
	GamePlayData.max_waves = CHAPTERS_DATA.levels[level_num].waves.size() - 1
	GamePlayData.current_wave = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	select_tile(get_global_mouse_position())
	if waves_finished and not game_finished:
		game_finished = true
		GamePlayData.game_ended.emit()
	if not game_finished and not GamePlayData.base_destroyed:
		if enemy_remaining == 0 and not spawning_enemies:
			if GamePlayData.current_wave <= GamePlayData.max_waves:
				spawn_wave()
				GamePlayData.current_wave += 1
			else: 
				waves_finished = true
		
	

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
	
	var wave: Array[WavePartResource] = CHAPTERS_DATA.levels[level_num].waves[GamePlayData.current_wave].wave_parts
	var total_parts: int = wave.size()
	var part_index: int = 0
	while(true):
		
		var part = wave[part_index]
		var type: String = part.type
		if part.loopings_state == "Start" and not loop_detected:
			loop_start_index = part_index
			loop_left = part.times_to_repeat
			loop_detected = true
			
		if part.loopings_state == "Stop" and loop_detected:
			loop_started = true
			loop_end_index = part_index
			loop_left -= 1
			if not loop_left:
				loop_detected = false
				loop_started = false
		
		for i in range(part.amount):
			var tank = load("res://Scenes/Entities/Tanks/" + type.to_lower() + ".tscn").instantiate() as Tank
			tank.color = part.colors[part.color]
			tank.max_hp = GameData.TankStats[part.type]["Hp"] * GameData.Hp_Scales_by_Color[part.color] * CHAPTERS_DATA.levels[level_num].waves[GamePlayData.current_wave-1].hp_scale
			tank.speed = GameData.TankStats[part.type]["Speed"]
			tank.money_on_death = GameData.TankStats[part.type]["Coins on Death"] * GameData.CoinDrop_Scales_by_Color[part.color]
			tank.main_target = level.end
			tank.global_position = level.start.global_position
			tank.destroyed.connect(update_num_of_enemies.bind(-1))
			tank.reached_end.connect(on_enemy_at_end)
			level.units.add_child(tank)
			tank.set_name(type + "_" + part.color)
			update_num_of_enemies(1)
			enemy_spawner.start(part.delay_btw_spawns)
			await enemy_spawner.timeout
		
		enemy_spawner.start(part.wait_after_pattern_complete)
		await enemy_spawner.timeout
		
		part_index += 1

		if loop_left > 0 and loop_started and part_index > loop_end_index:
			part_index = loop_start_index
		
		if part_index >= total_parts:
			break
	
	spawning_enemies = false

func update_num_of_enemies(amount):
	enemy_remaining = enemy_remaining + amount

func on_enemy_at_end(hp_left: float):
	GamePlayData.base_hp = max(0, GamePlayData.base_hp - hp_left)
