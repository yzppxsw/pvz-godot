extends Plant

const BULLET_SCENE := preload("res://Template/bullet/fume.tscn")
var animation:AnimatedSprite2D = null

@export var has_coffee:bool = false

func _ready() -> void:
	super()
	animation=$AnimatedSprite2D


func shoot() -> void:
	while true:
		await get_tree().create_timer(1).timeout
		if not has_zombie_ahead():
			animation.play("FumeShroom")
			continue
		animation.play("FumeShroomAttack")
		fire()
		await animation.animation_finished
		animation.play("FumeShroom")
		
func on_planted() -> void:
	var is_awake := not Gamedata.is_daytime or has_coffee
	if is_awake:
		animation.play("FumeShroom")
		shoot()
	else:
		animation.play("FumeShroomSleep")

func fire()->void:
	var bullet := BULLET_SCENE.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.position=get_position()+Vector2(40,-78)

func has_zombie_ahead()->bool:
	for zombie in get_tree().get_nodes_in_group("zombies"):
		var d: Vector2 = (zombie as Node2D).global_position - global_position
		if absf(d.y) <= ROW_TOLERANCE and d.x < 400 and d.x > 0:
			return true
	return false