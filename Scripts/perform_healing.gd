class_name PerformHealing extends TargetedEffect

@export var base_healing: int
@export var type: String

func _do(agent: Actor, source: CombatAction, targets: Array[Actor]):
	if targets == null:
		return
	for target in targets:
		match type:
			"Skill":
				target.regain_health(agent.stats.attributes["WIS"] + base_healing)
			"Item":
				target.regain_health(base_healing)
	return
