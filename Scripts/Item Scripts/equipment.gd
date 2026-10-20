class_name Equipment extends Resource

@export var equip_type: EquipType
@export var equip_slot: EquipSlot
@export var enhancement: int

@export var attr_bonus = {}
@export var s_resist_bonus = {}
@export var e_resist_bonus = {}

@export var special_effects: Array[TargetedEffect]

enum EquipType {
	WEAPON,
	ARMOR,
}

enum EquipSlot {
	MAIN_HAND,
	OFF_HAND,
	HEAD,
	BODY,
	ARMS,
	LEGS,
	ACCESSORY
}
