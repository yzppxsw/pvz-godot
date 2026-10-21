extends Node2D


func _ready() -> void:
	$Card.card_id = Gamedata.level
	$Card.set_up()
	var text=Gamedata.plants[Gamedata.level]["describe"]
	$describe.text=text
