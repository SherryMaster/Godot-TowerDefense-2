extends Control
class_name LevelDetailScreen

@onready var rewards: GridContainer = $Main/VBoxContainer/HBoxContainer/VBoxContainer2/Panel/Rewards
@onready var level_image: TextureRect = $Main/VBoxContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/VBoxContainer/LevelImage
@onready var level_name: Label = $Main/VBoxContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/VBoxContainer/LevelName

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_close_button_pressed() -> void:
	animation_player.play("exit")
