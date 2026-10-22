extends Area2D

signal pressed


@onready var Menu_Button: Sprite2D = $Sprite2D

func _ready() -> void:
	input_event.connect(click_menu_button)   # 自己连自己，永远不会连错


func click_menu_button(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		Gamedata.next_level()
		pressed.emit()