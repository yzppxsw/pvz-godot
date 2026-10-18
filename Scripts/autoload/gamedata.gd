extends Node

signal selection_changed
signal card_clicked_onGame
signal Game_started
signal sun_changed
signal card_planted
signal plant_landed(card_id:int)
signal level_score_changed
signal delete_mode_completed
signal game_over_changed

var level_score: int = 0
var level: int = 1
var game_over: bool = false
var is_daytime: bool = true
var game_started: bool = false
var delete_mode: bool = false
var holding_plant:Node2D=null
var holding_sholve:Node2D=null
var plants:Dictionary={}
var card_selected:= []
var max_select_num: int = 10
var sun: int = 9000
var plant_grid: Array[Array]=[]
var holding_plant_id:int=-1

func _load() -> void:
	var text := FileAccess.get_file_as_string("res://resources/graphics/Cards/ordered/plants.json")
	var data: Variant = JSON.parse_string(text)
	if data == null:
		print("Failed to parse JSON")
		return
	for plant in data["plants"]:
		plants[int(plant["id"])]=plant
	for plant in data["special"]:
		plants[int(plant["id"])]=plant

func _ready() -> void:
	_load()