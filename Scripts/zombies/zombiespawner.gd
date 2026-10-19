extends Node2D

const ZOMBIE_SCENE := preload("res://Template/zombies/normalzombie.tscn")
const SPAWN_X :int= 950
const ROWS_Y_NORMAL := [182, 280, 379, 477, 576]

# 每关的波次表:count = 本波僵尸数,delay = 距上一波开始的等待秒数
const LEVEL_WAVES := {
	1: [   # 10 只,首只 15 秒
		{"count": 1, "delay": 15.0},
		{"count": 2, "delay": 20.0},
		{"count": 3, "delay": 20.0},
		{"count": 4, "delay": 25.0},
	],
	2: [   # 14 只,节奏更紧
		{"count": 1, "delay": 12.0},
		{"count": 2, "delay": 18.0},
		{"count": 3, "delay": 18.0},
		{"count": 4, "delay": 20.0},
		{"count": 4, "delay": 22.0},
	],
	3: [   # 18 只,最后一波 8 只
		{"count": 1, "delay": 10.0},
		{"count": 2, "delay": 15.0},
		{"count": 3, "delay": 15.0},
		{"count": 4, "delay": 18.0},
		{"count": 8, "delay": 20.0},
	],
}

const WAVE_SPAWN_GAP: float = 1.5   # 同一波内两只僵尸的间隔

signal all_waves_spawned

var zombie_wave: int = 0

func _ready()->void:
	Gamedata.Game_started.connect(_on_Game_started)

func _on_Game_started()->void:
	if not LEVEL_WAVES.has(Gamedata.level):
		push_warning("zombiespawner: 没有第 %d 关的波次配置" % Gamedata.level)
		return
	run_level(Gamedata.level)

func run_level(level: int)->void:
	for wave in LEVEL_WAVES[level]:
		await get_tree().create_timer(wave["delay"]).timeout
		for n in wave["count"]:
			if Gamedata.game_over:
				return
			spawn_zombie()
			await get_tree().create_timer(WAVE_SPAWN_GAP).timeout
		zombie_wave += 1
	all_waves_spawned.emit()

func spawn_zombie()->void:
	var zombie := ZOMBIE_SCENE.instantiate()
	add_child(zombie)
	zombie.position = Vector2(SPAWN_X, ROWS_Y_NORMAL[pick_row()])

# 每关允许出现的行:1 关只有中间行,2 关 1-3 行,3 关全部
func pick_row()->int:
	if Gamedata.level==1:
		return 2
	elif Gamedata.level==2:
		return randi_range(1, 3)
	else:
		return randi_range(0, ROWS_Y_NORMAL.size() - 1)
