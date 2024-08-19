extends AnimatedSprite2D

@onready var stats_component: StatsComponent = $"../StatsComponent"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed_scale = stats_component.speed * stats_component.speed_power
