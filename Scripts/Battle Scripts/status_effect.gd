extends Resource
class_name StatusEffect

@export var name: String
@export var duration: int
@export var indefinite: bool

@export var apply_effects: Array[TargetedEffect]
@export var repeat_effects: Array[TargetedEffect]
@export var expire_effects: Array[TargetedEffect]
