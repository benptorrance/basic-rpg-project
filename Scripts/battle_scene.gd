extends Control

@onready var player_1 = $AllyZone/Player1
@onready var enemy_1 = $EnemyZone/Enemy1
@onready var allies = [player_1]
@onready var enemies = [enemy_1]
@onready var a_zone = $AllyZone
@onready var e_zone = $EnemyZone

@export var sel_actor: Actor = null

var t_order = {}
var t_index = 0

var flee = false

func _ready() -> void:
	$Overlay.visible = false
	$GameOverContainer.visible = false
	$VictoryScreen.visible = false
	player_1.load_stats("res://Content/Entities/Players/player_1.tres")
	enemy_1.load_stats("res://Content/Entities/Enemies/slime.tres")
	_cal_turn_order()
	_next_turn()

func _cal_turn_order() -> void:
	if player_1.stats.attributes["Dex"] > enemy_1.stats.attributes["Dex"]:
		t_order = [player_1, enemy_1]
	else:
		t_order = [enemy_1, player_1]

func _next_turn() -> void:
	##Highlight the image of the player whose turn it is.
	print("Next Turn")
	
	_check_actors()
	if flee:
		#End Battle. Show Flee Screen. Exit back to map
		return
	if sel_actor != null:
		sel_actor.end_turn()
	
	##Increment the index of the currently selected character then save that character to selected actor
	sel_actor = t_order[t_index]
	sel_actor.begin_turn()
	t_index = wrapi(t_index+1, 0, t_order.size())
	
	##Determine whether the current turn is for a player or enemy then do stuff for turns.
	if sel_actor.is_player:
		##Enable GUI to read inputs and be navigatable
		_menu_state(true)
		##Wait for button to be pressed.
	else:
		##Disable GUI's ability to read input and be navigated
		_menu_state(false)
		var think = sel_actor.get_node("ThinkAnimation")
		think.visible = true
		think.play("Thinking")
		await sel_actor.get_node("ThinkAnimation").animation_finished
		think.visible = false
		#Use action
		await get_tree().create_timer(0.5).timeout
		_next_turn()

##Checks the status of the actors if all actors on one side are dead and
##sets victory or defeat to true if one side is vanquished.
func _check_actors():
	##Checks the status of the actors if all actors on one side are dead and
	##sets victory or defeat to true if one side is vanquished.
	if allies.all(func(x): return x.living == false):
		_game_over()
	if enemies.all(func(x): return x.living == false):
		_battle_won()
	if allies.all(func(x): return x.living == false) and enemies.all(func(x): return x.living == false):
		_game_over()

#Handles the interactivity state of the menu when switching between player and ai turns.
func _menu_state(is_turn: bool) -> void:
	if is_turn:
		##loops through and enables buttons for the player's turn
		for child in $BattleMenus/ActionMenu/ActionList.get_children():
			child.disabled = false
		$BattleMenus/ActionMenu/ActionList/FightButton.grab_focus()
	else:
		##Sets the other action lists except for the main one as not visible, then loops through and
		##disables the buttons for the main action list to lock player selection during enemy turns.
		for child in $BattleMenus/ActionMenu.get_children():
			if child != $BattleMenus/ActionMenu/ActionList:
				child.visible = false
		for child in $BattleMenus/ActionMenu/ActionList.get_children():
			child.disabled = true

##Handles the gave over screen. Kicks the player out to the main screen
func _game_over() -> void:
	_menu_state(false)
	$Overlay.visible = true
	$GameOverContainer.visible = true
	pass

##Handles a battle victory. Shows victory screen, calculates rewards. Sends player
##back to the map
func _battle_won() -> void:
	_menu_state(false)
	$Overlay.visible = true
	$VictoryScreen.visible = true
	pass

##Handles player combat actions.
func _player_combat_action (action: CombatAction, targets: Array[Actor]):
	if sel_actor.is_player != true:
		return
	print("Player 1 Used a Skill")
	sel_actor.combat_action(action, targets)
	await get_tree().create_timer(0.5).timeout
	_next_turn()	

##Handles how the enemy decides what action to use.
func _enemy_action_decision():
	if sel_actor.is_player == true:
		return
	print(sel_actor.stats.char_name + " Used a Skill")

##Upon Combat action selection, this function is called. It will take the number associated with the
##pressed button and then find what action that correlates to in the selected actor's action lists
##then fetch_action calls the unit selection function of the appropriate zone.
func fetch_action(action:int, a_category: String):
	var c_action: CombatAction
	match a_category:
		"Basic":
			c_action = sel_actor.base_actions[action]
		"Skill":
			c_action = sel_actor.skill_actions[action]
		"Item":
			c_action = sel_actor.item_actions[action]
	var targets: Array[Actor]
	match c_action.tar_type:
		"Ally":
			targets = a_zone.unit_selection(sel_actor)
		"Enemy":
			var selected = false
			var x = 0
			var index: Array[int]
			while selected == false:
				if enemies[x].living:
					index = await e_zone.unit_selection(enemies[x])
					print(index)
					for i in index:
						targets.append(enemies[i])
					selected = true
				x += 1
	_player_combat_action(c_action,targets)
