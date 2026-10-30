class_name DealDamage extends TargetedEffect

@export var base_damage: int
@export var atk_stat: String
@export var def_stat: String
@export var act_type: String

func _do(agent: Actor, _source: CombatAction, targets: Array[Actor]):
	if targets == null:
		return
	for target in targets:
		var total_damage: int
		match act_type:
			"Skill":
				match atk_stat:
					"Str":
						total_damage = (agent.stats.attributes["Str"] + base_damage)
					"Wis":
						total_damage = (agent.stats.attributes["Wis"] + base_damage)
			"Item":
				match def_stat:
					"Armor":
						total_damage -= target.stats.attributes["Armor"]
						if total_damage < 0:
							total_damage = 0
					"Warding":
						total_damage -= target.stats.attributes["Warding"]
						if total_damage < 0:
							total_damage = 0
		match def_stat:
			"Armor":
				total_damage -= target.stats.attributes["Armor"]
				if total_damage < 0:
					total_damage = 0
			"Warding":
				total_damage -= target.stats.attributes["Warding"]
				if total_damage < 0:
					total_damage = 0
		target.take_damage(total_damage)
		BattleLogManager.add_entry(agent.stats.char_name + " Has dealt " + str(total_damage) + " to " + target.stats.char_name)
		BattleLogManager.update_display()
	return
