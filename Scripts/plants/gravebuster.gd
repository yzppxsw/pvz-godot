extends Plant 

var animation:AnimatedSprite2D=null

func _ready() -> void:
	super()
	hp=1000
	animation=$AnimatedSprite2D
	animation.play("GraveBuster")
	await animation.animation_finished
	die()


