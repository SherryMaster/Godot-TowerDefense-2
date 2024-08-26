extends Node2D
class_name GameScene
signal build_mode_started
signal build_mode_ended

const CHAPTERS_DATA = preload("res://Resources/GameData/chapters_data.tres")


@onready var level: Level = $Level
@onready var enemy_spawner: Timer = $EnemySpawner

@onready var build_bar: BuildBar = $UI/BuildBar
@onready var ui: CanvasLayer = $UI


var level_num: int = 1
var chapter_number: int = 1

var enemy_remaining: int = 0

var spawning_enemies: bool = false
var waves_finished: bool = false
var game_finished: bool = false

var tile_selection_layer: TileMapLayer
var tower_tiles_layer: TileMapLayer
var previous_selected_tile: Vector2i

# Building States
var build_mode: bool = false
var previous_build_type: String
var previous_button: BuildButton

var tile_build_mode: bool = false
var tile_build_loc_valid: bool = false

var tower_build_mode: bool = false
var tower_build_loc_valid: bool = false

var current_tile_cords: Vector2i
var current_tile_global_position: Vector2

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == 1 and not event.pressed:
			#select_tile(get_global_mouse_position())


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_selection_layer = level.tile_selector
	tower_tiles_layer = level.tower_tiles
	GamePlayData.max_waves = CHAPTERS_DATA.levels[level_num].waves.size() - 1
	GamePlayData.current_wave = 0
	
	# connecting_tiles
	for tile_button in build_bar.tile_buttons.get_children() as Array[BuildButton]:
		tile_button.pressed.connect(initiate_build_mode.bind("tile", tile_button))
		tile_button.cancel_button.pressed.connect(cancel_build_mode.bind("tile"))
	for tower_button in build_bar.tower_buttons.get_children():
		tower_button.pressed.connect(initiate_build_mode.bind("tower", tower_button))
		tower_button.cancel_button.pressed.connect(cancel_build_mode.bind("tower"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	select_tile(get_global_mouse_position())
	print("Cords: ", current_tile_cords, "\tPos: ", current_tile_global_position, "\t Build Valid: ", tile_build_loc_valid)
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
	if not (previous_selected_tile.x < 0 or previous_selected_tile.y < 0):
		tile_selection_layer.erase_cell(previous_selected_tile)
		previous_selected_tile = Vector2i(-1, -1)
	
	if tile_build_mode:
		var tile_cords = tile_selection_layer.local_to_map(m_pos)
		previous_selected_tile = tile_cords
		
		
		var road_tile_cords = level.road.local_to_map(m_pos)
		var tile_data = level.road.get_cell_tile_data(road_tile_cords)
		
		if not tile_data:
			tile_data = tower_tiles_layer.get_cell_tile_data(tile_cords)
		
		if tile_data:
			tile_build_loc_valid = false
		else:
			tile_build_loc_valid = true
		if not tile_data:
			tile_selection_layer.set_cell(tile_cords, 1, Vector2i(0, 0)) 
		else:
			tile_selection_layer.set_cell(tile_cords, 1, Vector2i(1, 0))
		
		current_tile_cords = tile_cords
		current_tile_global_position = tower_tiles_layer.map_to_local(tile_cords)
		

func initiate_build_mode(type, button: BuildButton):
	if build_mode:
		cancel_build_mode(previous_build_type)
	
	previous_build_type = type
	build_mode = true
	previous_button = button
	previous_button.cancel_button.show()
	
	if type == "tile":
		tile_build_mode = true
	elif type == "tower":
		tower_build_mode = true
	
	level.game_camera.on_build_mode_started()

func initiate_tile_build_mode():
	pass

func cancel_build_mode(type):
	previous_button.cancel_button.hide()
	build_mode = false
	
	if type == "tile":
		tile_build_mode = false
	elif type == "tower":
		tower_build_mode = false
	
	level.game_camera.on_build_mode_ended()

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
