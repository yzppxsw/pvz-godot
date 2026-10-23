extends Node2D

@warning_ignore("integer_division")  # 整数除法，结果为整数，向下取整

@export var unlock_card_id: int = 1 # 解锁的卡片id

var pool_cards: Array[Node]=[]

const COL=8  # 卡片池的列数
const ROW=5  # 卡片池的行数

const CARD_H=140*0.45
const CARD_W=100*0.45

const start_pos=Vector2(15,40)
const gap=Vector2(10,5)


const Card_Scene:=preload("res://Template/card.tscn")



func _ready() -> void:
	unlock_card_id=Gamedata.level
	set_up_cardpool()
	Gamedata.selection_changed.connect(refresh_pool_color)
	$StartButton.pressed.connect(GameStartButton)
	
func set_up_cardpool():
	for i in range(1,unlock_card_id+1):
		var card=Card_Scene.instantiate()
		card.card_id=i
		card.is_pool_card=true
		var row=(i-1)/COL         # 行数
		var col=(i-1)%COL         # 列数
		card.position=Vector2(col*(CARD_W+gap.x)+start_pos.x,row*(CARD_H+gap.y)+start_pos.y)
		add_child(card)
		pool_cards.append(card)
		card.set_up()

func _process(_delta: float) -> void:
	pass

func refresh_pool_color() -> void:     # 新增:按数组给池卡上色
	for card in pool_cards:
		if card.card_id in Gamedata.card_selected:
			card.Card_texture.modulate = Color.from_hsv(0, 0, 0.2)   # 已选 → 灰
		else:
			card.Card_texture.modulate = Color.from_hsv(0, 0, 1)     # 未选 → 白

func GameStartButton() -> void:
	if Gamedata.card_selected.size()<Gamedata.max_select_num:
		return
	Gamedata.game_started=true
	Gamedata.Game_started.emit()
