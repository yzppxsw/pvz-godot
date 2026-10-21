extends Node2D


func _ready() -> void:
	$Card.card_id = Gamedata.level
	$Card.Card_texture.texture=load(Gamedata.plants[Gamedata.level]["card"])
	$Card.sun_cost=Gamedata.plants[Gamedata.level]["sun_cost"]
	var text=Gamedata.plants[Gamedata.level]["describe"]
	$describe.text=text
