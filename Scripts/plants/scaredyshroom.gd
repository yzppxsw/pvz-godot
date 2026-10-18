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
		if has_zombie_area():
			continue
		fire()
	
func on_planted() -> void:
	var is_awake := not Gamedata.is_daytime or has_coffee
	if is_awake:
		shoot()
		while true:
			await get_tree().create_timer(0.1).timeout
			if not has_zombie_area():
				animation.play("ScaredyShroom")
			else:
				animation.play("ScaredyShroomCry")
	else:
		animation.play("ScaredyShroomSleep")

func fire()->void:
	var bullet := BULLET_SCENE.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.position=get_position()+Vector2(30,-20)

func has_zombie_area()->bool:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var d: Vector2 = (zombie as Node2D).global_position - global_position
		if absf(d.x) <= AOE_X:
			if d.y >= -160 and d.y <= 120:
				return true
	return false