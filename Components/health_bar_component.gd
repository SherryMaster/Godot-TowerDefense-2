@icon("res://Assets/CustomNodeIcons/health_bar_component.png")
extends TextureProgressBar
class_name HealthBarComponent

@export var show_amount: bool = false

@onready var label: Label = $Label

@onready var health_component: HealthComponent = $"../HealthComponent"

var x_offset
var y_offset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	x_offset = position.x
	y_offset = position.y
	top_level = true
	
	max_value = health_component.max_hp
	value = health_component.hp
	health_component.hp_changed.connect(update)
	
	if show_amount:
		label.visible = true
	else:
		label.visible = false
	
	label.text = str(health_component.hp)
	
	owner.ready.connect(update)


func _process(delta: float) -> void:
	global_position = get_parent().global_position + Vector2(x_offset, y_offset)
	if value == max_value:
		visible = false
	else:
		visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	
	label.text = str(health_component.hp)
	
	max_value = health_component.max_hp
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "value", health_component.hp, 0.5)
	
