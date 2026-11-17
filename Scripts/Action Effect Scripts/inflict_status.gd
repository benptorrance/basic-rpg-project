extends TargetedEffect
class_name InflictStatus

@export var status: STATUS
@export var chance: float

enum STATUS {
	POISONED
}

func _do(agent: Actor, targets: Array[Actor]):
	var s_effect: StatusEffect
	var s_resist: String
	match status:
			STATUS.POISONED:
				s_effect = load("res://Content/Status Effects/poisoned.tres")
				s_resist = "Poison Resist"
	for target in targets:
		if (chance - chance * target.stats.s_resists[s_resist])  >= randf():
			target.stats.status_effects.append(s_effect)
			BattleLogManager.add_entry(s_effect.name + " has been applied to " + target.stats.char_name)
		else:
			BattleLogManager.add_entry("Failed to apply: " + s_effect.name)
