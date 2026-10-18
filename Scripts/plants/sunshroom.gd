extends Plant

const SUN_SCENE := preload("res://Template/sunshine/sunshine.tscn")
var animation:AnimatedSprite2D = null
var is_big:bool = false

var current_sun_value: int = 15                    
var current_sun_size: Vector2 = Vector2(0.5, 0.5)

@export var has_coffee:bool = false

func produce_sun(sun_value:int,sun_size:Vector2) -> void:
	current_sun_value = sun_value                    
	current_sun_size = sun_size
	while true:
		var vector2D := Vector2(randf_range(0,10),randf_range(0,13))
		var sun := SUN_SCENE.instantiate()
		sun.sun_value=current_sun_value
		sun.scale=current_sun_size
		var cd:=randi_range(15,16)
		await get_tree().create_timer(cd).timeout
		get_tree().current_scene.add_child(sun)
		sun.position=get_global_position()+vector2D
		if is_queued_for_deletion():
			return

func _ready() -> void:
	super()
	animation=$AnimatedSprite2D

func on_planted() -> void:     
	var is_awake := not Gamedata.is_daytime or has_coffee
	if is_awake:
		animation.play("SunShroom")
		produce_sun(15,Vector2(0.5,0.5)) 
		await get_tree().create_timer(46).timeout
		animation.play("SunShroomBig")
		is_big=true
		current_sun_value = 25                
		current_sun_size = Vector2(1, 1)

	else:
		animation.play("SunShroomSleep")