extends Area2D

signal card_clicked

@export var card_id: int = 1

@onready var Card_texture: Sprite2D=$Sprite2D


var is_pool_card:bool=false

var is_cd:bool=false

var cd_time:float=0.0	# 冷却时间

var sun_cost:int=0	# 消耗

func _ready() -> void:
	set_up()
	input_event.connect(_on_card_input)
	Gamedata.plant_landed.connect(_on_plant_landed)

func _on_card_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !Gamedata.holding_plant and event.is_action_pressed("click"):
		if not Gamedata.game_started:
			if is_pool_card and card_id in Gamedata.card_selected:   # 点击卡片池中已选择的卡片
				return
			if card_id in Gamedata.card_selected:                    # 点击卡片选择框中已选择的卡片
				Gamedata.card_selected.erase(card_id)
			else:	                                                 # 点击卡片选择框中未选择的卡片
				if Gamedata.card_selected.size()<Gamedata.max_select_num:  # 最多选择max_select_num
					Gamedata.card_selected.append(card_id)
			Gamedata.selection_changed.emit()
		else:
			if is_cd:
				return
			else:
				if Gamedata.sun<sun_cost:
					return
				else:
					Gamedata.holding_plant_id=card_id
					hold_plant()
	elif Gamedata.holding_plant and event.is_action_pressed("click"):
		if Gamedata.holding_plant_id==card_id:
			Gamedata.holding_plant.queue_free()
			Gamedata.holding_plant=null
			Gamedata.holding_plant_id=-1


func set_up() -> void:    # 初始化卡片
	if card_id in Gamedata.plants:
		Card_texture.texture=load(Gamedata.plants[card_id]["card"])
		cd_time=Gamedata.plants[card_id]["cooldown_s"]
		sun_cost=Gamedata.plants[card_id]["sun_cost"]
		$suncost.text=str(sun_cost)
	else:
		print("card_id:", card_id, " 未找到数据")


func start_cd()->void:
	is_cd=true
	Gamedata.card_clicked_onGame.emit(is_cd,card_id)
	Gamedata.sun_changed.emit()
	await get_tree().create_timer(cd_time).timeout
	is_cd=false
	Gamedata.card_clicked_onGame.emit(is_cd,card_id)
	
func hold_plant()->void:
	var hold_plant_scene=load(str(Gamedata.plants[Gamedata.holding_plant_id]["scene"]))
	var holding_plant=hold_plant_scene.instantiate()
	Gamedata.holding_plant=holding_plant
	get_tree().current_scene.add_child(Gamedata.holding_plant)
	# 拿起时:不播动画,停在默认动画第一帧
	var anim := holding_plant.get_node_or_null("AnimatedSprite2D") as AnimatedSprite2D
	if anim:
		anim.stop()         # 停住
		anim.frame = 0      # 回到第一帧

func _process(_delta: float) -> void:
	if Gamedata.holding_plant:
		Gamedata.holding_plant.position=get_global_mouse_position()

func _on_plant_landed(id: int) -> void:
	if id == card_id:
		start_cd()
