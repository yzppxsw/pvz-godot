extends Node2D

@export var sun_value:int = 25

func _ready() -> void:
	$Area2D.input_event.connect(click_sunshine)
	await get_tree().create_timer(randf_range(6,8)).timeout
	queue_free()

func click_sunshine(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		Gamedata.sun+=sun_value
		Gamedata.sun_changed.emit()
		queue_free()
