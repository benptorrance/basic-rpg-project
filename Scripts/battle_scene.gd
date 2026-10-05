extends Control


@onready var _actions: ActionMenu = $BattleMenus/ActionMenu
@onready var _action_list: ActionList = $BattleMenus/ActionMenu/ActionList

var player_1:= load("res://Entities/Players/player_1.tres")

var enemy_1:= load("res://Entities/Enemies/base_slime.tres")


func _ready() -> void:
	_turn_order()
	pass

func _turn_order() -> void:
	if player_1.stats["Dex"] > enemy_1.stats["Dex"]:
		pass
	else:
		pass
	pass
