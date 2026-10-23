extends Node2D

@export var texture_6: Texture2D
@export var texture_7: Texture2D
@export var texture_8: Texture2D
@export var texture_9: Texture2D
@export var texture_10: Texture2D

@onready var ChooseBox: Sprite2D=$bar

const CARD_POS_START=Vector2(80,10)

const Card_Scene:=preload("res://Template/card.tscn")

func _ready() -> void:
	$sun.text=str(Gamedata.sun)
	if Gamedata.max_select_num == 6:
		ChooseBox.texture = texture_6
	elif Gamedata.max_select_num == 7:
		ChooseBox.texture = texture_7
	elif Gamedata.max_select_num == 8:
		ChooseBox.texture = texture_8
	elif Gamedata.max_select_num == 9:
		ChooseBox.texture = texture_9
	elif Gamedata.max_select_num == 10:
		ChooseBox.texture = texture_10
	Gamedata.selection_changed.connect(set_up_cards)  # 新增:监听选择变化信号
	Gamedata.card_clicked_onGame.connect(refresh_card)
	Gamedata.sun_changed.connect(sun_changed)
	Gamedata.Game_started.connect(refresh_all_cards)  # 游戏开始时设置卡片
	rebuild_slots()

func set_up_cards() -> void:
	print("set_up_cards")
	if Gamedata.game_started:
		return
	rebuild_slots()

func refresh_card(is_cd: bool,_card_id: int) -> void:
	for card in $SlotContainer.get_children():      # 遍历所有槽卡
		if card.card_id == _card_id:
			card.is_cd = is_cd
			_refresh_one(card)      # ← 交给统一判断
			return                                  # 找到就停,别继续找

func sun_changed() -> void:
	$sun.text=str(Gamedata.sun)
	refresh_all_cards()  # 太阳变化时刷新所有卡片状态

func _refresh_one(card) -> void:
	if not Gamedata.game_started:
		card.Card_texture.modulate = Color.from_hsv(0, 0, 1)     # 白
	elif card.is_cd or Gamedata.sun < card.sun_cost:
		card.Card_texture.modulate = Color.from_hsv(0, 0, 0.2)   # 灰
	else:
		card.Card_texture.modulate = Color.from_hsv(0, 0, 1)     # 白

func refresh_all_cards() -> void:
	for card in $SlotContainer.get_children():
		_refresh_one(card)

func rebuild_slots() -> void:
	for child in $SlotContainer.get_children():
		child.queue_free()
	for i in range(Gamedata.card_selected.size()):
		var card = Card_Scene.instantiate()
		card.card_id = Gamedata.card_selected[i]
		$SlotContainer.add_child(card)
		card.position = CARD_POS_START + Vector2(i * 51, 0)
	refresh_all_cards()      # 顺便应用阳光/冷却的灰色状态