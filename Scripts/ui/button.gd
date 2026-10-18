extends Area2D

signal pressed
signal released
@export var texture_normal: Texture2D
@export var texture_pressed: Texture2D

@onready var Menu_Button: Sprite2D = $Sprite2D

func _ready() -> void:
	input_event.connect(click_menu_button)   # 自己连自己，永远不会连错
	if texture_normal:
		Menu_Button.texture = texture_normal


func click_menu_button(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		Menu_Button.texture = texture_pressed
		pressed.emit()
		# print(name + " clicked")
	elif event.is_action_released("click"):
		Menu_Button.texture = texture_normal
		released.emit()

