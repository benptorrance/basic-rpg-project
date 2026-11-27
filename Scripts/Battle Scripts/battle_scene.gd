extends Control
class_name BattleScene

@onready var allies: Array [Actor]
@onready var enemies: Array [EnemyActor]
@onready var a_zone = $AllyZone
@onready var e_zone = $EnemyZone
@onready var act_menu = $BattleMenus/ActionMenu
@onready var turn_display = $TurnOrderDisplay
@export var sel_actor: Actor = null
@export var menu_layer: Array[ACTIVE_LAYERS]

var party: ActiveParty = load("res://Content/Entities/Players/Party Resources/active_party.tres")
var party_images = load("res://Content/Entities/Players/Party Resources/party_images.tres")
var enemy_images = ImageData

var t_order = []
var t_index = 0

var flee = false

##Enums for each of the active menu layers over the base layer.
enum ACTIVE_LAYERS {
	ACT_LIST,
	TARGETING,
}

func _ready() -> void:
	$Overlay.visible = false
	$GameOverContainer.visible = false
	$VictoryScreen.visible = false
	
	$BattleMenus/ActionMenu/ActionList.state_change.connect(state_changer)
	$EnemyZone.state_change.connect(state_changer)
	$AllyZone.state_change.connect(state_changer)
	
	BattleLogManager.add_entry("Battle Begins!")
	_menu_state(false)
	load_actors()
	act_menu._load(allies)
	turn_display.update_order()
	_next_turn()

func load_actors() -> void:
	party.load_active()
	for child in a_zone.get_children():
		match child.get_index():
			0:
				child.load_stats(party.paths[0])
				var images = party_images.load_image(child.stats.unit_id)
				child.texture = images[0].texture
				turn_display.add_unit(child, images[1])
			1:
				child.load_stats(party.paths[1])
				var images = party_images.load_image(child.stats.unit_id)
				child.texture = images[0].texture
				turn_display.add_unit(child, images[1])
			2:
				child.load_stats(party.paths[2])
				var images = party_images.load_image(child.stats.unit_id)
				child.texture = images[0].texture
				turn_display.add_unit(child, images[1])
			3:
				child.load_stats(party.paths[3])
				var images = party_images.load_image(child.stats.unit_id)
				child.texture = images[0].texture
				turn_display.add_unit(child, images[1])
		allies.append(child)
	for child in e_zone.get_children():
		var image:= Sprite2D.new()
		image.texture = load("res://Assets/Unit Sprites/Basic Enemies/test_enemy.png")
		child.load_stats("res://Content/Entities/Enemies/slime.tres")
		turn_display.add_unit(child, image)
		enemies.append(child)

func _next_turn() -> void:
	##Highlight the image of the player whose turn it is.
	
	_check_actors()
	if flee == true:
		_menu_state(false)
		$Overlay.visible = true
		$FledScreen.visible = true
		sel_actor.get_child(2).visible = false
		return
	if sel_actor != null:
		sel_actor.end_turn()
	
	
	##Save the current actor in the turn order, then if the index is pointing at the end of the turn order
	##Update the turn order and then
	sel_actor = t_order[t_index]
	t_index = wrapi(t_index+1, 0, t_order.size())
	
	
	##Check if ther actor is alive, if not then it will go to the next turn.
	if sel_actor.living:
		sel_actor.begin_turn()
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
			think.stop()
			turn_display.next_unit(sel_actor)
			_next_turn()
	else:
		turn_display.next_unit(sel_actor)
		_next_turn()

##Checks the status of the actors if all actors on one side are dead and
##sets victory or defeat to true if one side is vanquished.
func _check_actors():
	##Checks the status of the actors if all actors on one side are dead and
	##sets victory or defeat to true if one side is vanquished.
	if allies.all(func(x): return x.living == false):
		_game_over()
		_menu_state(false)
	if enemies.all(func(x): return x.living == false):
		_battle_won()
		_menu_state(false)
	if allies.all(func(x): return x.living == false) and enemies.all(func(x): return x.living == false):
		_game_over()
		_menu_state(false)

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

##Handles a battle victory. Shows victory screen, calculates rewards. Sends player
##back to the map
func _battle_won() -> void:
	_menu_state(false)
	$Overlay.visible = true
	$VictoryScreen.visible = true

func _flee_battle() -> void:
	var average: float = 0
	var flee_chance: float
	var rand_num: float = randf()
	for enemy in enemies:
		average += enemy.stats.attributes.Dex
	average = average / enemies.size()
	flee_chance = (sel_actor.stats.attributes.Dex / average) / 2
	if flee_chance >= rand_num:
		flee = true
	else:
		##Prevents the user from putting commands in while the BattleLogManager is
		##showing text
		_menu_state(false)
		BattleLogManager.add_entry(str("The party was unable to run away!"))
	turn_display.next_unit(sel_actor)
	_next_turn()

##Handles player combat actions.
func _player_combat_action (action: CombatAction, targets: Array[Actor]):
	if sel_actor.is_player != true:
		return
	sel_actor.combat_action(action, targets)
	_menu_state(false)
	##Waits to begin next turn until the battle log displays all text
	await BattleLogManager.log_cleared
	turn_display.next_unit(sel_actor)
	_next_turn()

func _fight():
	fetch_targets(sel_actor.stats.basic_attack)

func _defend():
	fetch_targets(sel_actor.stats.guard)

##Upon Combat action selection, this function is called. It will determine what
##zone targets need to be selected from and then call the unit selection function
##of that zone.
func fetch_targets(action: CombatAction):
	var selected = false
	var x = 0
	var index: Array[int]
	var targets: Array[Actor]
	
	match action.tar_type:
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
		"Self":
			targets.append(sel_actor)
	#Hides the Other sub menus so that after the action and enemy are selected, the sub menu doesn't
	#stay up.
	if menu_layer.is_empty() != true:
		menu_layer.clear()
	for child in $BattleMenus/ActionMenu.get_children():
		if child != $BattleMenus/ActionMenu/ActionList:
			child.visible = false
	_player_combat_action(action,targets)

func state_changer(add: bool, layer: int = 0):
	if add:
		match layer:
			0: 
				pass
			1:
				menu_layer.push_back(ACTIVE_LAYERS.ACT_LIST)
			2:
				menu_layer.push_back(ACTIVE_LAYERS.TARGETING)
	else:
		menu_layer.pop_back()
