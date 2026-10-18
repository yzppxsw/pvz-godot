extends Plant

const damage: int = 1800
var animation: AnimatedSprite2D =null

var has_coffee: bool = false

func _ready() -> void:
	super()
	animation = $AnimatedSprite2D


func _process(delta: float) -> void:
	pass

func on_planted()->void:
	var is_awake := not Gamedata.is_daytime or has_coffee
	if is_awake:
		animation.play("DoomShroom")
		await animation.animation_finished
		animation.scale=Vector2(1.5,1.5)
		animation.play("DoomShroomBoom")
		await animation.animation_finished
		aoe_damage(damage)
		remove_from_group("plants")
		animation.scale=Vector2(0.8,0.8)
		animation.position=Vector2(0,10)
		if  not Gamedata.is_daytime:
			animation.modulate=Color.from_hsv(0,0,0.5)
		can_delete=false
		animation.play("Dig")
		await get_tree().create_timer(60).timeout
		die()
	else:
		animation.play("DoomShroomSleep")

func aoe_damage(damage: int) -> void:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var aoe_d: Vector2 = (zombie as Node2D).global_position - global_position
		if absf(aoe_d.x) <= 380:
			if aoe_d.y >= -380 and aoe_d.y <= 380:
				zombie.take_boom_damage(damage)