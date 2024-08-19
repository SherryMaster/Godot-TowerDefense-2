extends TextureProgressBar
class_name HealthBarComponent

@export var show_amount: bool = false

@onready var label: Label = $Label

var health_component: HealthComponent
var stats_component : StatsComponent

var x_offset
var y_offset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	x_offset = position.x
	y_offset = position.y
	top_level = true
	
	health_component = get_parent().get_node("HealthComponent") as HealthComponent
	stats_component = get_parent().get_node("StatsComponent") as StatsComponent
	max_value = stats_component.max_hp
	value = stats_component.hp
	health_component.hp_changed.connect(update)
	
	if show_amount:
		label.visible = true
	else:
		label.visible = false
	
	label.text = str(stats_component.hp)


func _process(delta: float) -> void:
	global_position = get_parent().global_position + Vector2(x_offset, y_offset)
	if value == max_value:
		visible = false
	else:
		visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	
	label.text = str(stats_component.hp)
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "value", stats_component.hp, 0.5)
	
