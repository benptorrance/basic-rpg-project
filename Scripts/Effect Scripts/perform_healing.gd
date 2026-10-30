class_name PerformHealing extends TargetedEffect

@export var base_healing: int
@export var type: String

func _do(agent: Actor, _source: CombatAction, targets: Array[Actor]):
	if targets == null:
		return
	for target in targets:
		match type:
			"Skill":
				target.regain_health(agent.stats.attributes["WIS"] + base_healing)
			"Item":
				target.regain_health(base_healing)
		BattleLogManager.add_entry(agent.stats.char_name + " Has healed " + target.stats.char_name + " by " + str(base_healing))
		BattleLogManager.update_display()
	return
