extends Control

@onready var player_1 = $AllyZone/Player1
@onready var enemy_1 = $EnemyZone/Enemy1
var sel_actor: Actor = null

var t_order = {}
var t_index = 0

var game_over = false
var victory = false

func _ready() -> void:
	player_1.load_stats("res://Entities/Players/player_1.tres")
	enemy_1.load_stats("res://Entities/Enemies/slime.tres")
	_cal_turn_order()
	print("Player stats: " + str(player_1.stats))
	print("Player stats: " + str(enemy_1.stats))
	print(player_1)

func _cal_turn_order() -> void:
	if player_1.stats.attributes["Dex"] > enemy_1.stats.attributes["Dex"]:
		t_order = [player_1, enemy_1]
	else:
		t_order = [enemy_1, player_1]

func _next_turn() -> void:
	##Highlight the image of the player whose turn it is.
	##
	if game_over:
		##End Battle. Show Lose Screen.
		return
	if victory:
		##End Battle. Show Victory Screen. Calculate Rewards.
		return
	if sel_actor != null:
		sel_actor.end_turn()
	
	t_index = wrapi(t_index+1, 0, t_order.size())
	
	t_order[t_index].begin_turn()
	
	

func _basic_attack() -> void:
	var damage: int
	print("Attack!")
	damage = player_1.stats.attributes["Phys Attack"] - enemy_1.stats.attributes["Armor"]
	enemy_1.take_damage(damage)
	print("Slime new health: " + str(enemy_1.stats.attributes["Health"]))
