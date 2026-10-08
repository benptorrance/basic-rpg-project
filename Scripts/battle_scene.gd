extends Control

@onready var player_1 = $AllyZone/Player1
@onready var enemy_1 = $EnemyZone/Enemy1
@onready var allies = [player_1]
@onready var enemies = [enemy_1]

var sel_actor: Actor = null
var tar_actor: Actor = null
var rec_stop: int = 10

var t_order = {}
var t_index = 0

var defeat = false
var victory = false
var flee = false

func _ready() -> void:
	player_1.load_stats("res://Entities/Players/player_1.tres")
	enemy_1.load_stats("res://Entities/Enemies/slime.tres")
	_cal_turn_order()
	_next_turn()

func _cal_turn_order() -> void:
	if player_1.stats.attributes["Dex"] > enemy_1.stats.attributes["Dex"]:
		t_order = [player_1, enemy_1]
	else:
		t_order = [enemy_1, player_1]

func _next_turn() -> void:
	##Highlight the image of the player whose turn it is.
	print("next TUrn")
	if defeat:
		##End Battle. Show Lose Screen. Give choice to reload save
		_game_over()
		return
	if victory:
		##End Battle. Show Victory Screen. Calculate Rewards. Exit back to map
		return
	if flee:
		#End Battle. Show Flee Screen. Exit back to map
		return
	if sel_actor != null:
		sel_actor.end_turn()
	
	##Increment the index of the currently selected character then save that character to selected actor
	sel_actor = t_order[t_index]
	sel_actor.begin_turn()
	t_index = wrapi(t_index+1, 0, t_order.size())
	rec_stop -= 1
	print(t_index)
	print(sel_actor)
	print(rec_stop)
	
	##Determine whether the current turn is for a player or enemy then do stuff for turns.
	if sel_actor.is_player == true:
		##Enable GUI to read inputs and be navigatable
		pass
	else:
		##Disable GUI's ability to read input and be navigated
		##Select an ability
		pass
		
	
	_check_actors()
	if rec_stop != 0:
		_next_turn()
	

func _check_actors():
	##Checks the status of the actors if all actors on one side are dead and
	##sets victory or defeat to true if one side is vanquished.
	if allies.all(func(x): return x.living == false):
		defeat = true
	if enemies.all(func(x): return x.living == false):
		victory = true
	if defeat == true and victory == true:
		victory = false
	return 

func _game_over() -> void:
	##Handles the gave over screen and the ability to load a save.
	pass

func _basic_attack() -> void:
	var damage: int
	print("Attack!")
	damage = player_1.stats.attributes["Phys Attack"] - enemy_1.stats.attributes["Armor"]
	enemy_1.take_damage(damage)
	print("Slime new health: " + str(enemy_1.stats.attributes["Health"]))
	_check_actors()
