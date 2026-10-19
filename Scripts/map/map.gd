extends Node2D

@export var level: int = 1

@export var Rows: int = 5
@export var Cols: int = 9


@onready var Area: Area2D=$Lawn
@onready var Lawn: CollisionShape2D=$Lawn/CollisionShape2D
@onready var Highlight: Node2D=$highlight
@onready var Map: Sprite2D=$Lawn/Sprite2D
 

func _ready() -> void:
	level=Gamedata.level
	# print(Lawn.shape.size)
	Area.input_event.connect(_on_lawn_input)
	if level==1:
		Gamedata.is_daytime=true
		Map.texture=load("res://resources/graphics/Items/Background/Background_7.jpg")
	elif level==2:
		Gamedata.is_daytime=true
		Map.texture=load("res://resources/graphics/Items/Background/Background_8.jpg")
	elif level==3:
		Gamedata.is_daytime=true
		Map.texture=load("res://resources/graphics/Items/Background/Background_0.jpg")
	elif level==4:
		Gamedata.is_daytime=false
		Map.texture=load("res://resources/graphics/Items/Background/Background_1.jpg")
	elif level==5:
		Gamedata.is_daytime=true
		Map.texture=load("res://resources/graphics/Items/Background/Background_2.jpg")
	elif level==6:
		Gamedata.is_daytime=false
		Map.texture=load("res://resources/graphics/Items/Background/Background_3.jpg")

	if level>=1 and level<=4:
			Rows=5
	elif level==5 or level==6:
			Rows=6

	Gamedata.plant_grid.clear()
	for i in range(Rows):
		Gamedata.plant_grid.append([]) 
		for j in range(Cols):
			Gamedata.plant_grid[i].append(0)
	
	# print(Gamedata.plant_grid)

func _on_lawn_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseMotion:
		# print("鼠标移动事件")
		pass
	elif Input.is_action_just_pressed("click"):
		var x=randi_range(-2, 2)
		var y=randi_range(-3, 1)
		var size := (Lawn.shape as RectangleShape2D).size           #种植区域大小
		var local := Lawn.get_local_mouse_position() + size / 2.0   # 左上角为原点，获取鼠标位置
		var col := int(local.x / (size.x / Cols))                   # 计算鼠标点击的列
		var row := int(local.y / (size.y / Rows))                   # 计算鼠标点击的行
		var cell_size := Vector2(size.x / Cols, size.y / Rows)
		var cell_pos := Lawn.position - size / 2.0 + Vector2(col * cell_size.x, row * cell_size.y)
		# plant_landed(cell_pos,cell_size,x,y)
		if level == 1:
			if row==2:
				plant_landed(cell_pos,cell_size,x,y,row,col)
		elif level == 2:
			if row>=1 and row<=3:
				plant_landed(cell_pos,cell_size,x,y,row,col)
		else:
			plant_landed(cell_pos,cell_size,x,y,row,col)

		
		# var highlight_rect=Rect2(cell_pos, cell_size)
		# if row >= 0 and row < Rows and col >= 0 and col < Cols:
			# if Gamedata.game_started:
				# Highlight.set_highlight_rect(highlight_rect)
		# if Gamedata.holding_plant:
		# 	Gamedata.holding_plant.position=cell_pos+Vector2(cell_size.x/2 + x,cell_size.y+y)
		# 	Gamedata.plant_landed.emit(Gamedata.holding_plant_id)
		# 	Gamedata.holding_plant=null
		# 	Gamedata.sun-=Gamedata.plants[Gamedata.holding_plant_id]["sun_cost"]
		# 	Gamedata.sun_changed.emit()
		# 	# Highlight.set_highlight_rect(highlight_rect)

# func _process(_delta: float) -> void:
# 	if Input.is_action_just_pressed("click"):
# 		var size := (Lawn.shape as RectangleShape2D).size           #种植区域大小
# 		var local := Lawn.get_local_mouse_position() + size / 2.0   # 左上角为原点，获取鼠标位置
# 		var col := int(local.x / (size.x / Cols))
# 		var row := int(local.y / (size.y / Rows))
# 		var cell_size := Vector2(size.x / Cols, size.y / Rows)
# 		var cell_pos := Lawn.position - size / 2.0 + Vector2(col * cell_size.x, row * cell_size.y)
# 		var highlight_rect=Rect2(cell_pos, cell_size)
# 		if row >= 0 and row < Rows and col >= 0 and col < Cols:
# 			if Gamedata.game_started:
# 				Highlight.set_highlight_rect(highlight_rect)
# 		if Gamedata.holding_plant:
# 			Gamedata.holding_plant.position=cell_pos+Vector2(cell_size.x/2,cell_size.y-3)
# 			Gamedata.plant_landed.emit(Gamedata.holding_plant_id)
# 			Gamedata.holding_plant=null
# 			Gamedata.sun-=Gamedata.plants[Gamedata.holding_plant_id]["sun_cost"]
# 			Gamedata.sun_changed.emit()
# 			Highlight.set_highlight_rect(highlight_rect)
					
func plant_landed(cell_pos:Vector2,cell_size:Vector2,x:int,y:int,row:int,col:int)->void:
	if Gamedata.holding_plant and Gamedata.plant_grid[row][col]==0:
		Gamedata.plant_grid[row][col]=Gamedata.holding_plant_id
		Gamedata.holding_plant.row=row
		Gamedata.holding_plant.col=col
		Gamedata.holding_plant.position=cell_pos+Vector2(cell_size.x/2 + x,cell_size.y+y)
		Gamedata.plant_landed.emit(Gamedata.holding_plant_id)
		var anim := Gamedata.holding_plant.get_node_or_null("AnimatedSprite2D") as AnimatedSprite2D
		if anim:
			anim.play(anim.animation)      # 重新播放它 autoplay 那个动画
		Gamedata.holding_plant.on_planted() # 然后才激活行为
		Gamedata.holding_plant=null
		Gamedata.sun-=Gamedata.plants[Gamedata.holding_plant_id]["sun_cost"]
		Gamedata.sun_changed.emit()
