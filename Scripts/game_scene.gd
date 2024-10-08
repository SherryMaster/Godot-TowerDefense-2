extends Node2D
class_name GameScene
signal build_mode_started
signal build_mode_ended

@onready var level: Level = $Level
@onready var enemy_spawner: Timer = $EnemySpawner
@onready var preview_space: Node2D = $PreviewSpace
@onready var hud: CanvasLayer = $HUD
@onready var build_bar: BuildBar = $HUD/BuildBar

const CHAPTERS_DATA = preload("res://Resources/GameData/chapters_data.tres")

@onready var game_scene_top_bar: Control = $HUD/GameSceneTopBar

var enemy_remaining: int = 0

var spawning_enemies: bool = false
var waves_finished: bool = false
var wave_running:bool = false
var game_finished: bool = false

var tile_selection_layer: TileMapLayer
var tower_tiles_layer: TileMapLayer
var tower_occupation_layer: TileMapLayer
var previous_selected_tile: Vector2i

# Building States
var can_build: bool = true
var build_mode: bool = false
var current_button: BuildButton

var tile_build_mode: bool = false
var tile_build_loc_valid: bool = false

var tower_build_mode: bool = false
var tower_build_loc_valid: bool = false

var current_tile_cords: Vector2i
var current_tile_global_position: Vector2

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("HUD_Toggle"):
		hud.visible = !hud.visible
	
	if build_mode:
		if event.is_action_pressed("cancel_build"):
			cancel_build_mode()
	
	if event.is_action_released("click") and build_mode:
		if tile_build_mode:
			var success: bool = verify_and_build_tile()
			#if success:
				#cancel_build_mode("tile")
		
		if tower_build_mode:
			var success: bool = verify_and_build_tower()
			#if success:
				#cancel_build_mode("tower")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	tile_selection_layer = level.tile_selector
	tower_tiles_layer = level.tiles_layer
	tower_occupation_layer = level.towers_layer
	GamePlayData.max_waves = CHAPTERS_DATA.levels[GamePlayData.level_num].waves.size() - 1
	GamePlayData.current_wave = 0
	
	# connecting_tiles
	for tile_button in build_bar.tile_buttons.get_children() as Array[BuildButton]:
		tile_button.pressed.connect(initiate_build_mode.bind("tile", tile_button))
		tile_button.cancel_button.pressed.connect(cancel_build_mode)
	for tower_button in build_bar.tower_buttons.get_children():
		tower_button.pressed.connect(initiate_build_mode.bind("tower", tower_button))
		tower_button.cancel_button.pressed.connect(cancel_build_mode)
	
	# Setting play and pause button
	game_scene_top_bar.get_node("BG/HBC/Buttons/Play").pressed.connect(_on_play_button_press)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_num_of_enemies()
	if build_mode:
		select_tile(get_global_mouse_position())
		update_build_preview()
	if waves_finished and not game_finished:
		game_finished = true
		can_build = false
		GamePlayData.game_ended.emit()
	if not game_finished and not GamePlayData.base_destroyed:
		if enemy_remaining == 0 and not spawning_enemies and wave_running:
			if GamePlayData.current_wave <= GamePlayData.max_waves:
				wave_running = false
			else: 
				waves_finished = true
			GamePlayData.wave_ended.emit()

func select_tile(m_pos: Vector2):
	tile_selection_layer.clear()
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
	
	if tower_build_mode:
		var tile_cords = tile_selection_layer.local_to_map(m_pos)
		previous_selected_tile = tile_cords
		
		var tile_data = tower_tiles_layer.get_cell_tile_data(tile_cords)
		if tile_data:
			var occupied = tower_occupation_layer.get_cell_tile_data(tile_cords)
			if occupied == null:
				tower_build_loc_valid = true
			else:
				tower_build_loc_valid = false
		else:
			tower_build_loc_valid = false
		
		if tower_build_loc_valid:
			tile_selection_layer.set_cell(tile_cords, 1, Vector2i(0, 0))
		else:
			tile_selection_layer.set_cell(tile_cords, 1, Vector2i(1, 0))
			
		
		current_tile_cords = tile_cords
		current_tile_global_position = tower_tiles_layer.map_to_local(tile_cords)

func initiate_build_mode(type, button: BuildButton):
	if build_mode:
		cancel_build_mode()
	
	if can_build:
		build_mode = true
		current_button = button
		current_button.cancel_button.show()
		
		if type == "tile":
			tile_build_mode = true
			initiate_tile_build_mode()
		elif type == "tower":
			tower_build_mode = true
			initiate_tower_build_mode()
		
		level.game_camera.on_build_mode_started()

func initiate_tile_build_mode():
	var texture = Sprite2D.new()
	texture.texture = current_button.item_icon.texture
	texture.self_modulate = Color(1, 1, 1, 0.5)
	preview_space.add_child(texture)

func initiate_tower_build_mode():
	var tower_preview: Tower = current_button.item_preview.instantiate()
	tower_preview.preview_mode = true
	preview_space.add_child(tower_preview)

func verify_and_build_tile():
	if tile_build_loc_valid and GamePlayData.map_money >= GamePlayData.Session_Inventory.Tiles[current_button.button_index].placement_cost:
		tower_tiles_layer.set_cell(current_tile_cords, 2, current_button.tile_atlas_cords)
		
		GamePlayData.map_money -= GamePlayData.Session_Inventory.Tiles[current_button.button_index].placement_cost
		GamePlayData.Session_Inventory.Tiles[current_button.button_index].quantity -= 1
		current_button.refresh_ui()
		if GamePlayData.Session_Inventory.Tiles[current_button.button_index].quantity == 0:
			cancel_build_mode()
		return true
	return false

func verify_and_build_tower():
	if tower_build_loc_valid and GamePlayData.map_money >= GamePlayData.Session_Inventory.Towers[current_button.button_index].placement_cost:
		tower_occupation_layer.set_cell(current_tile_cords, 0, Vector2i(0, 0))
		
		var tower = GamePlayData.GAME_INVENTORY.Towers[current_button.button_index].tower_scene.instantiate() as Tower
		tower.global_position = current_tile_global_position
		level.towers.add_child(tower)
		
		GamePlayData.map_money -= GamePlayData.Session_Inventory.Towers[current_button.button_index].placement_cost
		GamePlayData.Session_Inventory.Towers[current_button.button_index].quantity -= 1
		current_button.refresh_ui()
		if GamePlayData.Session_Inventory.Towers[current_button.button_index].quantity == 0:
			cancel_build_mode()
		return true
	return false

func cancel_build_mode():
	current_button.cancel_button.hide()
	current_button = null
	build_mode = false
	preview_space.get_child(0).queue_free() if is_instance_valid(preview_space.get_child(0)) else null
	
	if tile_build_mode:
		tile_build_mode = false
	elif tower_build_mode:
		tower_build_mode = false
	
	select_tile(get_global_mouse_position())
	level.game_camera.on_build_mode_ended()

func update_build_preview():
	if tile_build_mode:
		preview_space.get_child(0).global_position = current_tile_global_position
	if tower_build_mode:
		preview_space.get_child(0).global_position = current_tile_global_position

func spawn_wave():
	spawning_enemies = true
	var loop_start_index: int = -1
	var loop_end_index: int = -1
	var loop_left: int = 0
	
	var loop_detected: bool = false
	var loop_started: bool = false
	
	var wave: Array[WavePart] =CHAPTERS_DATA.levels[GamePlayData.level_num].waves[GamePlayData.current_wave].wave_parts
	var total_parts: int = wave.size()
	var part_index: int = 0
	while(true):
		
		var part = wave[part_index]
		var type: String = WavePart.Type.keys()[part.type]
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
			var tank = load("res://Scenes/Entities/Tanks/" + type.to_snake_case() + ".tscn").instantiate() as Tank
			tank.color = part.colors[part.color]
			tank.max_hp = GameData.TankStats[part.type]["Hp"] * GameData.Hp_Scales_by_Color[part.color] * CHAPTERS_DATA.levels[GamePlayData.level_num].waves[GamePlayData.current_wave-1].hp_scale
			tank.speed = GameData.TankStats[part.type]["Speed"]
			tank.money_on_death = GameData.TankStats[part.type]["Coins on Death"] * GameData.CoinDrop_Scales_by_Color[part.color]
			tank.main_target = level.end
			tank.path_points = level.get_paths()
			tank.global_position = level.start.global_position
			tank.reached_end.connect(on_enemy_at_end)
			level.units.add_child(tank)
			tank.set_name(type + "_" + WavePart.Colors.keys()[part.color])
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

func update_num_of_enemies():
	enemy_remaining = get_tree().get_nodes_in_group("Enemy").size()

func on_enemy_at_end(hp_left: float):
	GamePlayData.base_hp = max(0, GamePlayData.base_hp - hp_left)

func _on_play_button_press():
	GamePlayData.wave_started.emit()
	wave_running = true
	spawn_wave()
	GamePlayData.current_wave += 1
	
