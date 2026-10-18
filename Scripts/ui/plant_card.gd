extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func plant_card(card_id: int) -> void:
	var plant_scene=load(str(Gamedata.plants[card_id]["scene"]))  #获取卡片场景
	var plant=plant_scene.instantiate()                           #实例化卡片
	plant.position=get_global_mouse_position()                    #卡片随鼠标移动
	add_child(plant)
	Gamedata.card_planted.emit(card_id)





