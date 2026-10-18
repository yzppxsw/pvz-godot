extends Plant

var animation:AnimatedSprite2D = null

@export var has_coffee:bool = false

func _ready() -> void:
	super()
	animation=$AnimatedSprite2D

func on_planted() -> void:
	var is_awake := not Gamedata.is_daytime or has_coffee
	if is_awake:
		animation.play("IceShroom")
		await animation.animation_finished
		take_forzen(2,4)
		die()
	else:
		animation.play("IceShroomSleep")

func take_forzen(duration: float,time:float) -> void:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		zombie.frozen(duration,time)

	