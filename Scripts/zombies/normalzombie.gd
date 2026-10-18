extends Zombie

enum State {WALK,ATTACK,DIE}

var state: State = State.WALK

var animation: AnimatedSprite2D =null

var is_dying: bool = false

func _ready()->void:
	super()
	animation = $AnimatedSprite2D
	score=10

func _process(delta: float)->void:
	freeze_tick(delta)
	var rand_speed =randf_range(0.9,1.1)
	if hp<=0:
		state = State.DIE
	var target_group: String = "zombies" if is_hypno else "plants"
	match state:
		State.WALK:
			animation.play("Zombie")
			position.x -=speed*delta*rand_speed
			if has_target_ahead(target_group):
				state = State.ATTACK
		State.ATTACK:
			animation.play("ZombieAttack")
			attack_cd-=delta
			position.x +=0
			if attack_cd<=0:
				attack_cd=ATTACK_CD
				var target = find_target(target_group)
				if target:
					target.take_damage(damage)
			if not has_target_ahead(target_group):
				state = State.WALK
		State.DIE:
			remove_from_group("zombies")
			if is_dying:
				return
			is_dying = true
			if not is_booming:
				animation.play("ZombieDie")
				position.x +=speed*delta*rand_speed*0.2
				await animation.animation_finished
				die()
			else:
				animation.play("BoomDie")
				position.x +=0
				await animation.animation_finished
				die()
			
func find_target(group: String)->Node2D:
	var nearest: Node2D = null
	for target in get_tree().get_nodes_in_group(group):
		var d: Vector2 = (target as Node2D).global_position - global_position
		if group=="plants":
			if absf(d.y) <= ROW_TOLERANCE and d.x < 0 and -d.x <= ATTACK_RANGE:
				if nearest == null or d.x > nearest.global_position.x - global_position.x:
					nearest = target as Node2D 
		else:
			if absf(d.y) <= ROW_TOLERANCE and d.x > 0 and d.x <= ATTACK_RANGE:
				if nearest == null or d.x < nearest.global_position.x - global_position.x:
					nearest = target as Node2D 
	return nearest