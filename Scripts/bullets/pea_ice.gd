extends Area2D


const atk:int =20

func _ready() -> void:
	z_index=10

func _process(delta: float) -> void:
	position+=Vector2(200,0)*delta

func _on_Area2D_body_entered(body: Node2D) -> void:
	if body.is_in_group("zombies"):
		body.take_freeze(2)
		body.take_damage(atk)
		queue_free()
