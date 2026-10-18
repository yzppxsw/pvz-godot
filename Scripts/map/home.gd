extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(zombie_come_home)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func zombie_come_home(body: Node2D) -> void:
	if body is Zombie:
		print("zombie come home")
		Gamedata.game_over = true
