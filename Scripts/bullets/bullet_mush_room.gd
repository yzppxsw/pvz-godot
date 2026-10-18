extends Area2D


const atk:int =20
var animation:AnimatedSprite2D = null
# var orginal_position:Vector2 = Vector2()

func _ready() -> void:
	z_index=10
	animation=$AnimatedSprite2D
	animation.play("default")
	# await get_tree().create_timer(1).timeout  
	# queue_free()
	# orginal_position=position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position+=Vector2(200,0)*delta
	# await get_tree().create_timer(1).timeout  
	# queue_free()
	pass

func _on_Area2D_body_entered(body: Node2D) -> void:
	if body.is_in_group("zombies"):
		body.take_damage(atk)
		queue_free()
