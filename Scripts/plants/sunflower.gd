extends Plant

const SUN_SCENE := preload("res://Template/sunshine/sunshine.tscn")

func produce_sun(sun_value:int,sun_size:Vector2) -> void:
	while true:
		# var vector2D := Vector2(randf_range(0,10),randf_range(0,13))
		var h=randi_range(20,25)
		var start_y=randi_range(-55,-50)
		var sun := SUN_SCENE.instantiate()
		sun.sun_value=sun_value
		sun.scale=sun_size
		var cd:=randi_range(20,25)
		await get_tree().create_timer(cd).timeout
		get_tree().current_scene.add_child(sun)
		sun.position=get_position()+Vector2(0,start_y)
		var start_pos = sun.position
		var end_pos = start_pos+Vector2(randi_range(10,30),randi_range(50,60))
		var tween:=sun.create_tween()
		tween.set_trans(Tween.TRANS_LINEAR) 
		tween.tween_method(move_arc.bind(sun,start_pos,end_pos,h),0.0,1.0,0.5)

		if is_queued_for_deletion():
			return

func _ready() -> void:
	super()

func on_planted() -> void:
	produce_sun(25,Vector2(1,1))

func move_arc(t:float,sun:Node2D,start_pos:Vector2,end_pos:Vector2,h:float)->void:
	sun.position.x=lerp(start_pos.x,end_pos.x,t)
	sun.position.y=lerp(start_pos.y,end_pos.y,t)-4*h*t*(1-t)