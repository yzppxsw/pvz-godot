extends Plant

const BULLET_SCENE := preload("res://Template/bullet/BulletMushRoom.tscn")
var animation:AnimatedSprite2D = null

@export var has_coffee:bool = false

func _ready() -> void:
	super()
	animation=$AnimatedSprite2D


func shoot() -> void:
	while true:
		var shoot_cd:=randf_range(0.8,1.5)
		await get_tree().create_timer(shoot_cd).timeout
		if not has_zombie_ahead():
			continue
		fire()
	
func on_planted() -> void:
	# if not Gamedata.is_daytime:
	# 	animation.play("PuffShroom")
	# 	shoot()
	# else:
	# 	if has_coffee:
	# 		animation.play("PuffShroom")
	# 		shoot()
	# 	else:
	# 		animation.play("PuffShroomSleep")
	var is_awake := not Gamedata.is_daytime or has_coffee
	if is_awake:
		animation.play("PuffShroom")
		shoot()
	else:
		animation.play("PuffShroomSleep")

func fire()->void:
	var bullet := BULLET_SCENE.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.position=get_position()+Vector2(30,-5)
	await get_tree().create_timer(1).timeout
	if bullet:
		bullet.queue_free()

func has_zombie_ahead()->bool:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var d: Vector2 = (zombie as Node2D).global_position - global_position
		if absf(d.y) <= ROW_TOLERANCE and d.x < 300 and d.x > 0:
			return true
	return false