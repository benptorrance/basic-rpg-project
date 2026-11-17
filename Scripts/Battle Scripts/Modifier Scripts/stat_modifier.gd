extends Modifier
class_name StatModifier

var stat: STAT
var is_flat: bool
var flat: int
var percent: float

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
