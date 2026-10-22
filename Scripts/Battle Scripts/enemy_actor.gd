class_name EnemyActor extends Actor

#Create functions for the following:
	#Loot Generation after battle
	#Variable stat generation when the enemy is created for the battle


func generate_loot():
	pass

func decision():
	var action: CombatAction = stats.base_actions[0]
	var index: int = randi() % 4
	return [action, index]
