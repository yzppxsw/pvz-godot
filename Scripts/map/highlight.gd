extends Node2D

@export var color: Color = Color(1, 1, 0, 0.5) # 高亮颜色，默认黄色半透明

var highlight_rect: Rect2 

func set_highlight_rect(rect: Rect2) -> void:
	highlight_rect = rect
	queue_redraw()

func _draw() -> void:
	if highlight_rect:
		draw_rect(highlight_rect, color, false, 2)