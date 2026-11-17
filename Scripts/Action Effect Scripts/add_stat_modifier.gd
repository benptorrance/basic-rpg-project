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
		var mod = StatModifier.new()
		mod.name = name
		mod.duration = duration
		mod.stat = stat
		if is_flat == true:
			mod.flat = flat
		else:
			mod.percent = percent
		target.stat_modifiers.append(mod)
