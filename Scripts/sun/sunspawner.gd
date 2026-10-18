extends Node2D

const Sun:= preload("res://Template/sunshine/sunshine.tscn")

func _ready() -> void:
	Gamedata.Game_started.connect(_on_Game_started)


func _process(delta: float) -> void:
	pass

func _on_Game_started()->void:
	await get_tree().create_timer(5).timeout
	spawn_sunshine()

func spawn_sunshine()->void:
	if Gamedata.is_daytime:
		var sun := Sun.instantiate()
		add_child(sun)
		sun.position = Vector2(randi_range(100, 800), randi_range(0, 20))
		var tweens:=get_tree().create_tween()
		tweens.tween_property(sun, "position:y", sun.position.y+randi_range(200,600), randi_range(4,6))
		await get_tree().create_timer(randf_range(6,8)).timeout
		spawn_sunshine()
	else:
		return