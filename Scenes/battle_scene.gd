extends Control


@onready var _actions: ActionMenu = $BattleMenus/ActionMenu
@onready var _action_list: ActionList = $BattleMenus/ActionMenu/ActionList

var player_1:= BattleCharacter.new()
var player_2:= BattleCharacter.new()
var player_3:= BattleCharacter.new()
var player_4:= BattleCharacter.new()

var enemy_1:= BattleCharacter.new()
var enemy_2:= BattleCharacter.new()
var enemy_3:= BattleCharacter.new()
var enemy_4:= BattleCharacter.new()

var characters = [player_1,player_2,player_3,player_4,enemy_1,enemy_2,enemy_3,enemy_4]

func _ready() -> void:
	characters[0].char_name = "Akayu"
	characters[1].char_name = "Akayu"
	characters[2].char_name = "Akayu"
	characters[3].char_name = "Akayu"
	characters[4].char_name = "Slime 1"
	characters[5].char_name = "Slime 2"
	characters[6].char_name = "Slime 3"
	characters[7].char_name = "Slime 4"

func _turn_order() -> void:
	pass
