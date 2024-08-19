extends Area2D
class_name HitBoxComponent

var health_component: HealthComponent
var stats_component: StatsComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component = get_parent().get_node("HealthComponent") as HealthComponent
	stats_component = get_parent().get_node("StatsComponent") as StatsComponent
	area_entered.connect(on_area_entered)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_area_entered(body: Node2D) -> void:
	if body is ProjectileComponenet:
		health_component.damage(body.damage)
		body.destroy()
