extends Node2D

const MAP_SCENE = preload("res://Scene/map.tscn")


func _ready() -> void:
	$Start.pressed.connect(Game_start_menu)


func _process(_delta: float) -> void:
	pass

func Game_start_menu() -> void:
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_packed(MAP_SCENE)
