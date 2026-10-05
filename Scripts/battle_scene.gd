extends Control


@onready var _actions: ActionMenu = $BattleMenus/ActionMenu
@onready var _action_list: ActionList = $BattleMenus/ActionMenu/ActionList

var player_1:= load("res://Entities/Players/player_1.tres")
var enemy_1:= load("res://Entities/Enemies/base_slime.tres")
var sel_actor = null

var t_order = {}

var game_over = false
var victory = false

func _ready() -> void:
	_cal_turn_order()
	print("Player stats: " + str(player_1.stats))
	print("Player stats: " + str(enemy_1.stats))

func _cal_turn_order() -> void:
	if player_1.stats["Dex"] > enemy_1.stats["Dex"]:
		t_order = [player_1, enemy_1]
	else:
		t_order = [enemy_1, player_1]

func _basic_attack() -> void:
	print("Attack!")
	enemy_1.stats["Health"] -= player_1.stats["Phys Attack"] - enemy_1.stats["Armor"]
	print("Slime new health: " + str(enemy_1.stats["Health"]))
