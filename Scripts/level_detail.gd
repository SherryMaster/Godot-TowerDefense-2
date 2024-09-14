extends Control
class_name LevelDetailScreen

@onready var rewards: GridContainer = $Main/VBoxContainer/HBoxContainer/VBoxContainer2/Panel/Rewards
@onready var level_image: TextureRect = $Main/VBoxContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/VBoxContainer/LevelImage
@onready var level_name: Label = $Main/VBoxContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/VBoxContainer/LevelName
@onready var play: Button = %Play

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func clear_rewards_ui():
	for child in rewards.get_children():
		child.queue_free()

func _on_close_button_pressed() -> void:
	animation_player.play("exit")
