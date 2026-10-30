class_name EnemyActor extends Actor

#Create functions for the following:
	#Loot Generation after battle
	#Variable stat generation when the enemy is created for the battle
var ai = EnemyAI

##Overwrites the inherited function to include the EnemyAI resource in the loading process
func load_stats(path: String) -> void:
	var temp = load(path)
	#var temp2 = load(path)
	stats = temp.duplicate()
	ai = load("res://Content/Entities/Enemies/Enemy AI/slime_ai.tres")
	is_player = false

func begin_turn():
	get_child(3).visible = true
	BattleLogManager.add_entry(stats.char_name + "'s turn has begun!")
	BattleLogManager.add_entry(stats.char_name + " has " + str(stats.attributes["Health"]) + " health")
	BattleLogManager.update_display()

func end_turn():
	get_child(3).visible = false

func generate_loot():
	pass

func decision(actor: EnemyActor, allies: Array[EnemyActor], enemies: Array[Actor]):
	var action: CombatAction
	var targets: Array[Actor]
	var rule_met: AIRule
	
	for rule in ai.rules:
		if rule.condition_met(actor,allies,enemies):
			action = rule.action
			rule_met = rule
			break
	if action != null:
		var temp = rule_met._fetch_targets(actor,allies,enemies)
		targets = temp
	else:
		#do basic attack
		action = stats.base_actions[0]
		targets.append(enemies[randi() % 4])
	actor.combat_action(action, targets)
