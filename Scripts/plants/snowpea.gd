extends Plant

const PEANORMAL_SCENE := preload("res://Template/bullet/PeaIce.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func shoot() -> void:
	while true:
		var shoot_cd:=randf_range(0.8,1.5)
		await get_tree().create_timer(shoot_cd).timeout
		if not has_zombie_ahead():
			continue
		var peanormal := PEANORMAL_SCENE.instantiate()
		get_tree().current_scene.add_child(peanormal)
		peanormal.position=get_position()+Vector2(30,-55)
func on_planted() -> void:   	
	shoot()
