class_name CombatAction extends Resource

@export var action_name: String
@export var description: String
@export var action_cat: String
@export var action_type: String
@export var mana_cost: int
@export var health_cost: int

@export var tar_type: String
@export var element: String
@export var use_weapon_element: bool
@export var effects: Array[TargetedEffect]
