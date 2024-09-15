extends Tower
class_name GunTower

var tower_name: String = "scout_tower"

func _ready() -> void:
	general_ready()

func _physics_process(delta: float) -> void:
	if not preview_mode:
		select_tank()
		target_tank()
		shoot()
