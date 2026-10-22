extends Node2D

func _ready() -> void:
	$Card.card_id = Gamedata.level+1
	$Card.set_up()
	var text=Gamedata.plants[Gamedata.level+1]["describe"]
	$describe.text=text
	$Nextlevel.pressed.connect(next_level)

func next_level() -> void:
	get_tree().change_scene_to_file("res://Scene/map.tscn")
