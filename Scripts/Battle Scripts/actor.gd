class_name Actor extends Sprite2D

@export var stats: Stats
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
	BattleLogManager.update_display()

func end_turn():
	get_child(2).visible = false

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
	for x in action.effects:
		x._do(self, action, targets)

#Handles playing a sound when the Actor uses a move/takes damage/heals
func _play_audio():
	pass
