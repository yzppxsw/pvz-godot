extends Plant

var damage: int = 1800
var grown_cd: float = 15.0

var animation: AnimatedSprite2D = null

func _ready() -> void:
	super()
	animation = $AnimatedSprite2D

func on_planted()->void:
	animation.play("PotatoMineInit")
	await get_tree().create_timer(grown_cd).timeout
	animation.play("PotatoMine")
	while true: 
		await get_tree().create_timer(0.1).timeout
		if has_zombie_ahead():
			animation.play("PotatoMineExplode")
			await animation.animation_finished
			aoe_damage(damage)
			die()
			return

func has_zombie_ahead()->bool:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var d: Vector2 = (zombie as Node2D).global_position - global_position
		if absf(d.y) <= ROW_TOLERANCE and absf(d.x) <= 42:
			return true
	return false

func aoe_damage(damage: int) -> void:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var aoe_d: Vector2 = (zombie as Node2D).global_position - global_position
		if absf(aoe_d.x) <= 42:
			if absf(aoe_d.y) <= 10:
				zombie.take_boom_damage(damage)