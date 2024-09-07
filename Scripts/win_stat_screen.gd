extends Control
signal back_button_press
signal restart_button_press

@onready var status_text_label: Label = %StatusTextLabel
@onready var back_button: Button = $Panel/VBoxContainer/Panel/MarginContainer/HBoxContainer/BackButton
@onready var restart_button: Button = $Panel/VBoxContainer/Panel/MarginContainer/HBoxContainer/RestartButton

var status_text: String = "You Win"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	status_text_label.text = status_text


func _on_back_button_pressed() -> void:
	back_button_press.emit()


func _on_restart_button_pressed() -> void:
	restart_button_press.emit()
