extends Area2D


const atk:int =20
var animation:AnimatedSprite2D = null
# var orginal_position:Vector2 = Vector2()

func _ready() -> void:
	z_index=10
	animation=$AnimatedSprite2D
	animation.play("default")
	await animation.animation_finished
	queue_free()

func _process(delta: float) -> void:
	pass

func _on_Area2D_body_entered(body: Node2D) -> void:
	if body.is_in_group("zombies"):
		body.take_damage(atk)