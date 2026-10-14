class_name DealDamage extends TargetedEffect

@export var base_damage: int
@export var stat: String

func _do(agent: Actor, source: CombatAction, targets: Array[Actor]):
	if targets == null:
		return
	for target in targets:
		var total_damage: int
		match stat:
			"Str":
				total_damage = (agent.stats.attributes["Str"] + base_damage) - target.stats.attributes["Armor"]
			"Wis":
				total_damage = (agent.stats.attributes["Wis"] + base_damage) - target.stats.attributes["Warding"]
		target.take_damage(total_damage)
		print(agent.stats.char_name + " Has dealt " + str(total_damage) + " to " + target.stats.char_name)
	return
