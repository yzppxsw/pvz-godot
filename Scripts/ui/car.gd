extends Area2D

var speed: float = 300.0
var is_moving: bool = false

func _ready() -> void:
	body_entered.connect(_on_zombie_entered)

func _on_zombie_entered(body: Node) -> void:
	if not body.is_in_group("zombies"):
		return
	body.die()
	if not is_moving:
		move()

func move() -> void:
	is_moving = true	
	
func _process(delta: float) -> void:
	if not is_moving:
		return
	position.x += speed * delta
	if position.x >= 1200:
		queue_free()