extends Area2D
var map:Node2D=null
var DIM := Color.from_hsv(0, 0, 0.2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(zombie_come_home)
	map=get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func zombie_come_home(body: Node2D) -> void:
	if body is Zombie:
		Gamedata.game_over = true
		Gamedata.game_over_changed.emit()
		for zombie in get_tree().get_nodes_in_group("zombies"):
			zombie.speed=0
		var tween = create_tween()
		tween.tween_property(body, "position", Vector2(-50, 370), 1.2)
		tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		await tween.finished
		body.is_home = true
		body.enter_attack_state()
		dim_except(body)

func dim_except(keep: Node2D) -> void:
	# 背景
	map.get_node("Lawn/Sprite2D").modulate = DIM

	# 植物(跳过 keep,防止魅惑僵尸被重复处理)
	for plant in get_tree().get_nodes_in_group("plants"):
		if plant != keep:
			plant.modulate = DIM

	# 僵尸(跳过进屋那只)
	for zombie in get_tree().get_nodes_in_group("zombies"):
		if zombie != keep:
			zombie.modulate = DIM

	# UI
	for ui in map.get_node("Camera2D").get_children():
		ui.modulate = DIM

	# 主角保持原色
	keep.modulate = Color.WHITE
