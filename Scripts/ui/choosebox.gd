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


func set_up_cards() -> void:
	if Gamedata.game_started:
		return
	else:
		for child in $SlotContainer.get_children():      # 先清掉旧槽卡
			child.queue_free()

		for i in range(Gamedata.card_selected.size()):   # 再按数组重建
			var card = Card_Scene.instantiate()
			card.card_id = Gamedata.card_selected[i]
			$SlotContainer.add_child(card)               # 放进容器,不是直接加
			card.position = CARD_POS_START + Vector2(i * 51, 0)

func refresh_card(is_cd: bool,_card_id: int) -> void:
	for card in $SlotContainer.get_children():      # 遍历所有槽卡
		if card.card_id == _card_id:                # 找到点击的那张
			if is_cd:
				card.Card_texture.modulate = Color.from_hsv(0, 0, 0.2)   # 冷却中 → 灰
			else:
				card.Card_texture.modulate = Color.from_hsv(0, 0, 1)     # 恢复 → 白
			return                                   # 找到就停,别继续找

func sun_changed() -> void:
	$sun.text=str(Gamedata.sun)