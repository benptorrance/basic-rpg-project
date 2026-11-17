extends TargetedEffect
class_name AddStatModifier

@export var name: StringName
@export var duration: int
@export var stat: STAT
@export var is_flat: bool
@export var flat: int
@export var percent: float

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
	WARD
}

func _do(agent: Actor, targets: Array[Actor]):
	for target in targets:
		var exists: bool
		var mod = StatModifier.new()
		mod.name = name
		mod.duration = duration
		mod.stat = stat
		mod.intensity = 1
		if is_flat == true:
			mod.flat = flat
			mod.is_flat = true
		else:
			mod.percent = percent
		for modifier in target.stat_modifiers:
			if modifier.name == mod.name:
				exists = true
				modifier.duration = mod.duration
				if modifier.intensity < 3:
					modifier.intensity += 1
			else:
				pass
		if exists == true:
			pass
		else:
			target.stat_modifiers.append(mod)
