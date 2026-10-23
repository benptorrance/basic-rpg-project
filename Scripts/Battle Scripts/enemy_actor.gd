class_name EnemyActor extends Actor

#Create functions for the following:
	#Loot Generation after battle
	#Variable stat generation when the enemy is created for the battle

func load_stats(path: String) -> void:
	var temp = load(path)
	stats = temp.duplicate()
	is_player = stats.is_player

func generate_loot():
	pass

func decision():
	var action: CombatAction
	var index: int
	
	match stats.tactics:
		EnemyStats.TACTICS.BASIC:
			action = stats.base_actions[0]
			index = randi() % 4
		EnemyStats.TACTICS.CASTER:
			pass
		EnemyStats.TACTICS.HEALER:
			pass
		EnemyStats.TACTICS.BERSERK:
			pass
		EnemyStats.TACTICS.TANK:
			pass
		EnemyStats.TACTICS.ROGUE:
			pass
		EnemyStats.TACTICS.SUMMONER:
			pass
		EnemyStats.TACTICS.BOSS:
			pass
	
	return [action, index]
