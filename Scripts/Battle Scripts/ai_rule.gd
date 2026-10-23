extends Resource
class_name AIRule

@export var cond_target: COND_TARGET
@export var cond_type: TYPE
@export_range(0.0,1.0) var chance: float
@export_range(0.0,1.0) var threshold: float
@export var status: STATUS
@export var action: CombatAction
@export var act_target: ACT_TARGET

enum COND_TARGET{
	SELF,
	ALLY,
	ENEMY
}

enum TYPE{
	HEALTH_ABOVE,
	HEALTH_BELOW,
	HAS_STATUS,
	MISSING_STATUS,
	ALWAYS,
}

enum STATUS{
	STANDARD,
	DEFENCE,
}

enum ACT_TARGET{
	RANDOM,
	HIGHEST_HEALTH,
	LOWEST_HEALTH,
	WITH_STATUS,
}

func condition_met(actor: EnemyActor, allies: Array[EnemyActor], enemies: Array[Actor]) -> bool:
	var met: bool = false
	match cond_type:
		TYPE.ALWAYS:
			if chance >= randf():
				met = true
		TYPE.HEALTH_ABOVE:
			if chance >= randf():
				met = true
		TYPE.HEALTH_BELOW:
			pass
		TYPE.HAS_STATUS:
			pass
		TYPE.MISSING_STATUS:
			pass
	return met

func _fetch_targets(actor: EnemyActor, allies: Array[EnemyActor], enemies: Array[Actor]) -> Array:
	var targets: Array[Actor]
	match act_target:
		ACT_TARGET.RANDOM:
			match action.tar_type:
				"Self":
					pass
				"Ally":
					pass
				"Enemy":
					var index: int = randi() % 4
					targets.append(enemies[index])
		ACT_TARGET.HIGHEST_HEALTH:
			pass
		ACT_TARGET.LOWEST_HEALTH:
			pass
		ACT_TARGET.WITH_STATUS:
			pass
	print("Fetched Targets " + str(targets))
	return targets
