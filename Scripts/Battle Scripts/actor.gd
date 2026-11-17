class_name Actor extends Sprite2D

@export var stats: Stats
@export var stat_modifiers: Array[StatModifier]
@export var is_player: bool
var living: bool = true

##This section contains the functions that are responsible for managing the actor's data.

func load_stats(path: String) -> void:
	var temp = load(path)
	stats = temp.duplicate()
	is_player = stats.is_player

func save_stats(path: String) -> void:
	##Save the data to the resource file.
	ResourceSaver.save(stats, path)


##Functions that handle the gameplay.

func begin_turn():
	get_child(2).visible = true
	BattleLogManager.add_entry(stats.char_name + "'s turn has begun!")
	BattleLogManager.add_entry(stats.char_name + " has " + str(stats.attributes["Health"]) + " health")
	apply_and_update_effects()
	await BattleLogManager.update_display()

func end_turn():
	get_child(2).visible = false

func apply_and_update_effects():
	for status in stats.status_effects:
		for effect in status.repeat_effects:
			effect._do(self, [self])
		status.duration -= 1
		if status.duration == 0:
			for effect in status.expire_effects:
				effect._do(self, [self])
			BattleLogManager.add_entry(stats.char_name + " is no longer " + status.name)
	##Using a duplicate of the array so that modifying it doesn't cause issues.
	for mod in stat_modifiers.duplicate():
		mod.duration -= 1
		if mod.duration == 0:
			stat_modifiers.pop_at(stat_modifiers.find(mod))

func take_damage(damage: int) -> void:
	stats.attributes["Health"] -= damage
	if stats.attributes["Health"] <= 0:
		stats.attributes["Health"] = 0
		BattleLogManager.add_entry(stats.char_name + " Has been slain!")
		BattleLogManager.update_display()
		_death()

func regain_health(healing: int) -> void:
	stats.attributes["Health"] += healing
	if stats.attributes["Health"] >= stats.attributes["Max Health"]:
		stats.attributes["Health"] = stats.attributes["Max Health"]

func _death():
	self.visible = false
	living = false

func combat_action (action: CombatAction, targets: Array[Actor]):
	var target_names: String = ""
	for target in targets:
		if target == targets[0]:
			target_names += target.stats.char_name
		else:
			target_names += " and " + target.stats.char_name
	if action.action_name == "Guard":
		BattleLogManager.add_entry(stats.char_name + " has put up their guard!")
	else:
		BattleLogManager.add_entry(stats.char_name + " used " + action.action_name + " on " + target_names)
	for x in action.effects:
		x._do(self, targets)
	for mod in stat_modifiers:
		print(stats.char_name + " has " + mod.name + " at intensity " + str(mod.intensity) + " for " + str(mod.duration) + " turns")
	BattleLogManager.update_display()

#Handles playing a sound when the Actor uses a move/takes damage/heals
func _play_audio():
	pass
