extends Node2D

var sholve_texture:Sprite2D
const SHOLVE_SCENE:= preload("res://Template/sholve.tscn")

func _ready() -> void:
	sholve_texture=$sholve_area/sholve
	Gamedata.delete_mode_completed.connect(_on_delete_mode_completed)

func _on_sholve_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if !Gamedata.holding_sholve and event.is_action_pressed("click"):
		sholve_texture.visible=false
		var sholve=SHOLVE_SCENE.instantiate()
		Gamedata.holding_sholve=sholve
		Gamedata.delete_mode=true
		add_child(Gamedata.holding_sholve)
	elif Gamedata.holding_sholve and event.is_action_pressed("click"):
		sholve_texture.visible=true
		Gamedata.holding_sholve.queue_free()
		Gamedata.delete_mode=false
		Gamedata.holding_sholve=null


func _process(_delta: float) -> void:
	if Gamedata.holding_sholve:
		var mouse_pos=get_global_mouse_position()
		Gamedata.holding_sholve.global_position=mouse_pos

func _on_delete_mode_completed() -> void:
	sholve_texture.visible=true
	Gamedata.holding_sholve.queue_free()
	Gamedata.delete_mode=false
	Gamedata.holding_sholve=null