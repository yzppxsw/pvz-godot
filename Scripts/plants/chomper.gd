extends Plant

var animation : AnimatedSprite2D=null
# var damage: int = 1800
var is_digesting: bool = false

func _ready() -> void:
	super()
	animation=$AnimatedSprite2D

func _process(_delta: float) -> void:
	pass

# func on_planted() -> void:
# 	while true:
# 		animation.play("Chomper")
# 		if has_zombie_ahead() and not is_digesting:
# 			animation.play("ChomperAttack")
# 			take_a_bite(damage)
# 			await animation.animation_finished
# 			is_digesting = true
# 		if is_digesting:
# 			animation.play("ChomperDigest")
# 			await get_tree().create_timer(12).timeout
# 			animation.play("Chomper")
# 			is_digesting = false

func on_planted() -> void:
	while true:
		await get_tree().create_timer(0.1).timeout    # ← 每 0.1 秒看一眼,防死循环
		if has_zombie_ahead() and not is_digesting:
			animation.play("ChomperAttack")
			await animation.animation_finished         # 咬合动画播完
			take_a_bite()
			is_digesting = true
			animation.play("ChomperDigest")
			await get_tree().create_timer(12).timeout  # 消化 12 秒
			is_digesting = false
			animation.play("Chomper")

func has_zombie_ahead()->bool:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var d: Vector2 = (zombie as Node2D).global_position - global_position
		if absf(d.y) <= ROW_TOLERANCE and d.x > 0 and d.x <120:
			return true
	return false

func take_a_bite(_damage: int=1800) -> void:
	var nearest: Zombie = null
	var nearest_dist:=INF
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var z := zombie as Zombie
		var aoe_d: Vector2 = z.global_position - global_position
		if aoe_d.x <= 300 and absf(aoe_d.y) <= ROW_TOLERANCE:
			if aoe_d.length() < nearest_dist: # 找到最近的僵尸
				nearest_dist = aoe_d.length()
				nearest = z
	if nearest:
		nearest.die()