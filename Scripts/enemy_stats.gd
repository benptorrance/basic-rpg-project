extends Stats
class_name EnemyStats

@export var base_experience: int
@export var base_money: int
@export var tactics: TACTICS
@export var loot: Array[ItemData]

enum TACTICS{
	BASIC,
	CASTER,
	HEALER,
	BERSERK,
	TANK,
	ROGUE,
	SUMMONER,
	BOSS,
}
