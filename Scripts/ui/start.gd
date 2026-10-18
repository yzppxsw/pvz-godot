extends Area2D

const ADVENTURE_0 := preload("res://resources/graphics/Screen/Adventure_0.png")
const ADVENTURE_1 := preload("res://resources/graphics/Screen/Adventure_1.png")

@onready var Button_start: Sprite2D = $Sprite2D


func click_start_button(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		Button_start.texture = ADVENTURE_1
		print("Start button clicked")
	elif event.is_action_released("click"):
		Button_start.texture = ADVENTURE_0
