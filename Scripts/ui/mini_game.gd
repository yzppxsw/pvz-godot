extends Area2D

const MiniGameButton_0 := preload("res://resources/graphics/Screen/littleGameButton_0.png")
const MiniGameButton_1 := preload("res://resources/graphics/Screen/littleGameButton_1.png")

@onready var MiniGame_Button: Sprite2D = $Sprite2D


func click_mini_game_button(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		MiniGame_Button.texture = MiniGameButton_1
		print("MiniGame button clicked")
	elif event.is_action_released("click"):
		MiniGame_Button.texture = MiniGameButton_0


