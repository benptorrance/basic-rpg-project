class_name DealDamage extends TargetedEffect

@export var base_damage: int
@export var atk_stat: String
@export var def_stat: String
@export var dmg_type: String

enum STAT {
	STR,
	VIT,
	DEX,
	WIS,
	LUK,
	MAX_HEALTH,
	PHYS_ATTACK,
	ARMOR,
	MAGI_ATTACK,
	WARDING
}

func _do(agent: Actor, targets: Array[Actor]):
	var defenses
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
				defenses = float(target.stats.attributes["Armor"])
				for mod in target.stat_modifiers:
					if mod.stat == STAT.ARMOR:
						if mod.is_flat == true:
							defenses += mod.flat * mod.intensity
						else:
							defenses += (target.stats.attributes["Armor"] * mod.percent) * mod.intensity
					else:
						pass
				total_damage -= defenses
				if total_damage < 0:
					total_damage = 0
			"Warding":
				defenses = target.stats.attributes["Warding"]
				for mod in target.stat_modifiers:
					if mod.stat == STAT.WARDING:
						if mod.is_flat:
							defenses += mod.flat * mod.intensity
						else:
							defenses += (target.stats.attributes["Warding"] * mod.percent) * mod.intensity
					else:
						pass
				total_damage -= defenses
				if total_damage < 0:
					total_damage = 0
			"None":
				pass
		target.take_damage(total_damage)
		BattleLogManager.add_entry(target.stats.char_name + " has taken " + str(total_damage) + " damage")
	return
