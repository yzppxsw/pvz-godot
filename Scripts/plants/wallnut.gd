extends Plant

var animation:AnimatedSprite2D=null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	hp=4000
	animation=$AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if hp<=4000 and hp>3000:
		animation.play("WallNut")
	elif hp<=3000 and hp>1000:
		animation.play("WallNut_cracked1")
	else:
		animation.play("WallNut_cracked2")