extends Plant

const damage: int = 1800
var animation: AnimatedSprite2D =null

func _ready() -> void:
	super()
	animation = $AnimatedSprite2D


func _process(delta: float) -> void:
	pass

func on_planted()->void:
	animation.play("CherryBomb")
	await animation.animation_finished
	aoe_damage(damage)
	die()