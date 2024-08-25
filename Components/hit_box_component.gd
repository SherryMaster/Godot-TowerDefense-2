extends Area2D
class_name HitBoxComponent
signal got_hit

var damage_to_deal: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	set_collision_layer_value(6, true)
	set_collision_mask_value(5, true)
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: HurtBoxComponent) -> void:
	if area.owner.team_id != owner.team_id:
		got_hit.emit()
