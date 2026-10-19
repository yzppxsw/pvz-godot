extends Node2D

const ZOMBIE_SCENE := preload("res://Template/zombies/normalzombie.tscn")
const SPAWN_X :int= 950
const ROWS_Y_NORMAL := [182, 280, 379, 477, 576]

@export var spawner_interval: float = 3

var zombie_wave: int = 0
func _ready()->void:
	Gamedata.Game_started.connect(_on_Game_started)
	Gamedata.level_score_changed.connect(_on_Hide_Score)
	

func _on_Game_started()->void:
	await get_tree().create_timer(15).timeout
	spawn_zombie()

func _on_Hide_Score()->void:
	if Gamedata.level==1:
		if Gamedata.level_score>=10 and zombie_wave==0:
			await get_tree().create_timer(3).timeout
			spawn_zombie()
			await get_tree().create_timer(1.5).timeout
			spawn_zombie()
			zombie_wave+=1

func spawn_zombie()->void:
	var zombie := ZOMBIE_SCENE.instantiate()
	add_child(zombie)
	# zombie.position = Vector2(SPAWN_X, ROWS_Y_NORMAL[randi_range(0, ROWS_Y_NORMAL.size() - 1)])
	if Gamedata.level==1:
		zombie.position = Vector2(SPAWN_X, ROWS_Y_NORMAL[2])
	elif Gamedata.level==2:
		zombie.position = Vector2(SPAWN_X, ROWS_Y_NORMAL[randi_range(1, 3)])
	elif Gamedata.level==3:
		zombie.position = Vector2(SPAWN_X, ROWS_Y_NORMAL[randi_range(0, ROWS_Y_NORMAL.size() - 1)])