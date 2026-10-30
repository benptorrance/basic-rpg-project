extends Control

@onready var allies: Array [Actor]
@onready var enemies: Array [EnemyActor]
@onready var a_zone = $AllyZone
@onready var e_zone = $EnemyZone
@onready var battle_log = $BattleText

@export var sel_actor: Actor = null

var t_order = []
var t_index = 0

var flee = false

func _ready() -> void:
	$Overlay.visible = false
	$GameOverContainer.visible = false
	$VictoryScreen.visible = false
	
	BattleLogManager.add_entry("Battle Begins!")
	_menu_state(false)
	load_actors()
	_cal_turn_order()
	_next_turn()

func load_actors() -> void:
	for child in a_zone.get_children():
		match child.get_index():
			0:
				child.load_stats("res://Content/Entities/Players/player_1.tres")
			1:
				child.load_stats("res://Content/Entities/Players/player_2.tres")
			2:
				child.load_stats("res://Content/Entities/Players/player_3.tres")
			3:
				child.load_stats("res://Content/Entities/Players/player_4.tres")
		allies.append(child)
		t_order.append(child)
	for child in e_zone.get_children():
		child.load_stats("res://Content/Entities/Enemies/slime.tres")
		enemies.append(child)
		t_order.append(child)

func _cal_turn_order() -> void:
	for i in range(0, 8):
		for x in range(i+1,8):
			if t_order[i].stats.attributes.Dex < t_order[x].stats.attributes.Dex:
				var temp = t_order[i]
				t_order[i] = t_order[x]
				t_order[x] = temp
			#If speeds are equal, swap 50% of the time.
			if t_order[i].stats.attributes.Dex == t_order[x].stats.attributes.Dex:
				pass

func _next_turn() -> void:
	##Highlight the image of the player whose turn it is.
	
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
	
	await BattleLogManager.log_cleared
	
	##Determine whether the current turn is for a player or enemy then do stuff for turns.
	if sel_actor.is_player:
		##Enable GUI to read inputs and be navigatable
		_menu_state(true)
		##Program waits for an action to be selected, which calls fetch_action and the turn process continues
	else:
		##Disable GUI's ability to read input and be navigated
		_menu_state(false)
		var think = sel_actor.get_node("ThinkAnimation")
		think.visible = true
		think.play("Thinking")
		await sel_actor.get_node("ThinkAnimation").animation_finished
		think.visible = false
		
		##The EnemyActor has the function that decides what action and target will be selected
		#The stats resource will be modified to have a variable that determines what kind of brain
		#the enemy has. Decision will call a different sub function based on that brain variable.
		#Examples: Berserker, Healer, Mage, Specific Boss name
		sel_actor.decision(sel_actor, enemies, allies)
		##Timer is here so that enemy turns will wait for the action to resolve before their turn ends
		#When action animations are implemented a timer here will prevent the turn from going to the
		#next enemy when the animation is still playing.
		await BattleLogManager.log_cleared
		await get_tree().create_timer(1.0).timeout
		think.stop()
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
	sel_actor.combat_action(action, targets)
	_menu_state(false)
	##Waits to begin next turn until the battle log displays all text
	await BattleLogManager.log_cleared
	_next_turn()	

##Upon Combat action selection, this function is called. It will take the number associated with the
##pressed button and then find what action that correlates to in the selected actor's action lists
##then fetch_action calls the unit selection function of the appropriate zone.
func fetch_action(action:int, a_category: String):
	var c_action: CombatAction
	var selected = false
	var x = 0
	var index: Array[int]
	var targets: Array[Actor]
	
	match a_category:
		"Basic":
			c_action = sel_actor.stats.base_actions[action]
		"Skill":
			c_action = sel_actor.stats.skill_actions[action]
		"Item":
			c_action = sel_actor.stats.item_actions[action]
	match c_action.tar_type:
		"Ally":
			while selected == false:
				if allies[x].living:
					index = await a_zone.unit_selection(allies[x])
					for i in index:
						targets.append(allies[i])
					selected = true
				x += 1
		"Enemy":
			while selected == false:
				if enemies[x].living:
					index = await e_zone.unit_selection(enemies[x])
					for i in index:
						targets.append(enemies[i])
					selected = true
				x += 1
	#Hides the Other sub menus so that after the action and enemy are selected, the sub menu doesn't
	#stay up.
	for child in $BattleMenus/ActionMenu.get_children():
		if child != $BattleMenus/ActionMenu/ActionList:
			child.visible = false
	_player_combat_action(c_action,targets)
