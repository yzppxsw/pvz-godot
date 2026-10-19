extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(zombie_come_home)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func zombie_come_home(body: Node2D) -> void:
	if body is Zombie:
		print("zombie come home")
		body.is_home = true
		Gamedata.game_over = true
		Gamedata.game_over_changed.emit()
		for zombie in get_tree().get_nodes_in_group("zombies"):
			zombie.speed=0
		var tween = create_tween()
		tween.tween_property(body, "position", Vector2(-50, 370), 1.2)
		tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		await tween.finished
		body.enter_attack_state()
