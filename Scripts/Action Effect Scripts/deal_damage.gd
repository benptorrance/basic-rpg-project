class_name DealDamage extends TargetedEffect

@export var base_damage: int
@export var atk_stat: String
@export var def_stat: String
@export var dmg_type: String

func _do(agent: Actor, targets: Array[Actor]):
	if targets == null:
		return
	for target in targets:
		var total_damage: int
		match dmg_type:
			"Skill":
				match atk_stat:
					"Str":
						total_damage = (agent.stats.attributes["Str"] + base_damage)
					"Wis":
						total_damage = (agent.stats.attributes["Wis"] + base_damage)
			"Item":
				total_damage = base_damage
			"Poisoned":
				total_damage = target.stats.attributes["Max Health"] * 0.1
				BattleLogManager.add_entry(target.stats.char_name + " is Poisoned!")
		match def_stat:
			"Armor":
				total_damage -= target.stats.attributes["Armor"]
				if total_damage < 0:
					total_damage = 0
			"Warding":
				total_damage -= target.stats.attributes["Warding"]
				if total_damage < 0:
					total_damage = 0
			"None":
				pass
		target.take_damage(total_damage)
		BattleLogManager.add_entry(target.stats.char_name + " has taken " + str(total_damage) + " damage")
	return
