class_name Weapon extends Equipment

@export var damage: int
@export var w_type: WeaponType
@export var can_offhand: bool = false
@export var is_two_handed: bool = false


enum WeaponType {
	SWORD,
	SPEAR,
	AXE,
	KNIFE,
	HAMMER,
	FIST,
	BOW,
	WAND,
	STAFF,
	TOME,
	SHIELD,
}
