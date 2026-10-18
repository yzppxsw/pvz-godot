extends Plant

const BULLET_SCENE := preload("res://Template/plants/hypnoshroom.tscn")
var animation:AnimatedSprite2D = null

@export var has_coffee:bool = false

func _ready() -> void:
	super()
	hp=200
	animation=$AnimatedSprite2D

func on_planted() -> void:
	var is_awake := not Gamedata.is_daytime or has_coffee
	if is_awake:
		animation.play("HypnoShroom")
		while true:
			await get_tree().create_timer(0.1).timeout
			for target in get_tree().get_nodes_in_group("zombies"):
				var d: Vector2 = (target as Node2D).global_position - global_position
				if abs(d.y) <= 5 and d.x > 0 and d.x <= 25:
					target.take_hypno()
					die()
	else:
		animation.play("HypnoShroomSleep")


