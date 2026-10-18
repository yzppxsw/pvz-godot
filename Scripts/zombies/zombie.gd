extends CharacterBody2D

class_name Zombie

@export var Max_HP: int = 200
@export var ARMOR: int = 0
@export var DAMAGE:int = 100
@export var SPEED: float = 20
@export var ATTACK_CD: float = 1.0

const ATTACK_RANGE: int = 25
const ROW_TOLERANCE: float = 5.0   # 同行容差:y 差小于这个算同行

var hp: int = 0
var armor: int = 0
var damage: int = 0
var speed: float = 0
var attack_cd: float = 0


var is_booming: bool = false
var is_hypno: bool = false
var is_forzen: bool = false
var freeze_time_left: float = 0.0

var score: int = 0
var is_dead: bool = false

var collision:CollisionShape2D=null

func _ready() -> void:
	add_to_group("zombies")
	hp=Max_HP
	armor=ARMOR
	damage=DAMAGE
	speed=SPEED
	attack_cd=ATTACK_CD
	z_index=2

	collision=$CollisionShape2D


func take_damage(damage: int) -> void:
	hp-=damage
		
func die() -> void:
	if is_dead:
		return
	is_dead = true
	Gamedata.level_score += score
	Gamedata.level_score_changed.emit()
	queue_free()

func has_target_ahead(group: String)->bool:
	for target in get_tree().get_nodes_in_group(group):
		var d:=(target as Node2D).global_position-global_position
		if group=="plants":
			if abs(d.y)<=ROW_TOLERANCE:
				if d.x<0:
					if -d.x<=ATTACK_RANGE:
						return true
		else:
			if abs(d.y)<=ROW_TOLERANCE:
				if d.x>0:
					if d.x<=ATTACK_RANGE:
						return true
	return false

func take_boom_damage(damage: int) -> void:
	is_booming=true
	hp-=damage

func take_freeze(duration: float) -> void:
	is_forzen=true
	freeze_time_left=duration
	modulate = Color.from_hsv(0.55, 0.78, 0.9)
	speed = SPEED*0.5
	$AnimatedSprite2D.speed_scale = 0.5 

func freeze_tick(delta: float) -> void:
	if is_forzen:
		freeze_time_left-=delta
		if freeze_time_left<=0:
			is_forzen=false
			modulate = Color.from_hsv(0, 0, 1)      
			speed = SPEED 
			$AnimatedSprite2D.speed_scale = 1 

func take_hypno() -> void:
	is_hypno=true
	$AnimatedSprite2D.flip_h=true
	collision.position.x=-58
	modulate = Color.from_hsv(0.97, 0.24, 1)  
	speed=SPEED*-1
	remove_from_group("zombies")
	add_to_group("plants")

func frozen(duration: float,time:float) -> void:
	is_forzen=true
	freeze_time_left=duration
	modulate = Color.from_hsv(0.55, 0.78, 0.9)
	speed = 0
	$AnimatedSprite2D.speed_scale = 0 
	await get_tree().create_timer(duration).timeout
	take_freeze(time)
