extends Camera2D


const CARD_SELECT_POS=Vector2(-450,-213)
const CHOOSEBOX_SCENE:=preload("res://Template/choosebox.tscn")
const CARD_SELECT_SCENE:=preload("res://Template/card_selsect.tscn")
const SHOLVE_SCENE:=preload("res://Template/sholve_box.tscn")

func _ready() -> void:
	Gamedata.Game_started.connect(_on_Game_started)
	Gamedata.game_over_changed.connect(_on_game_over_changed)
	await move_to(Vector2(750, 300), 0.7)
	set_up_card_select()
	set_up_choosebox()
	# set_up_shoulve()

func move_to(target: Vector2,duration: float) -> void:              #游戏相机移动
	var tween = create_tween()
	tween.tween_property(self, "position", target, duration)
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	await tween.finished     

func set_up_card_select() -> void:
	var card_select=CARD_SELECT_SCENE.instantiate()
	add_child(card_select)

	var target_pos=CARD_SELECT_POS
	card_select.position=target_pos+Vector2(0,300)

	var tween = create_tween()
	tween.tween_property(card_select, "position", target_pos, 0.2)
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_Game_started() -> void:
	move_to(Vector2(450, 300), 0.7)        	# 卡片池移动到正确位置
	$CardSelect.queue_free()    # 卡片池移动完成后，删除卡片池节点
	await get_tree().create_timer(0.7).timeout # 等待0.7秒，确保卡片池节点被删除
	set_up_sholve_box()

func set_up_choosebox() -> void:
	var choosebox=CHOOSEBOX_SCENE.instantiate()
	add_child(choosebox)
	var target_pos=Vector2(-450, -300)
	choosebox.position=target_pos+Vector2(0,-300)
	var tween = create_tween()
	tween.tween_property(choosebox, "position", target_pos, 0.2)
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func set_up_sholve_box() ->void:
	var sholve=SHOLVE_SCENE.instantiate()
	add_child(sholve)
	var target_pos=Vector2(180, -265)
	sholve.position=target_pos+Vector2(0,-300)
	var tween = create_tween()
	tween.tween_property(sholve, "position", target_pos, 0.5)
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_game_over_changed() -> void:
	if Gamedata.game_over:
		move_to(Vector2(250, 300), 0.7)
		get_node("../Gameover").visible = true