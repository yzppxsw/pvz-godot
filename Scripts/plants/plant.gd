extends Area2D

class_name Plant

@export var Max_HP: int = 200
@export var ROW_TOLERANCE: float = 10.0
@export var AOE_X: float = 123
var hp: int = 0
var can_delete: bool = true
var row: int = 0
var col: int = 0


func _ready() -> void:
	hp=Max_HP
	add_to_group("plants")

func take_damage(damage: int) -> void:
	hp-=damage
	if hp<=0:
		die()

func die() -> void:
	Gamedata.plant_grid[row][col]=0
	queue_free()

func on_planted()->void:
	pass

func has_zombie_ahead()->bool:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var d: Vector2 = (zombie as Node2D).global_position - global_position
		if absf(d.y) <= ROW_TOLERANCE and d.x > 0:
			return true
	return false

func aoe_damage(damage: int) -> void:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var aoe_d: Vector2 = (zombie as Node2D).global_position - global_position
		if absf(aoe_d.x) <= AOE_X:
			if aoe_d.y >= -160 and aoe_d.y <= 120:
				zombie.take_boom_damage(damage)

func delete_plant() -> void:
	if can_delete:
		die()
	else:
		return

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Gamedata.delete_mode and event.is_action_pressed("click"):
		delete_plant()
		Gamedata.emit_signal("delete_mode_completed")