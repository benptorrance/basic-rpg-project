class_name Actor extends Sprite2D

@export var stats: Stats


var target_scale: float = 1.0

func begin_turn():
	target_scale = 1.1

func end_turn():
	target_scale = 0.9

func take_damage(damage: int) -> void:
	stats.attributes["Health"] -= damage
	if stats.attributes["Health"] <= 0:
		stats.attributes["Health"] = 0
		print(stats.char_name + " Has been slain!")

func regain_health(healing: int) -> void:
	stats.attributes["Health"] += healing
	if stats.attributes["Health"] >= stats.attributes["Max Health"]:
		stats.attributes["Health"] = stats.attributes["Max Health"]


func load_stats(path: String) -> void:
	stats = load(path)
	
func save_stats(path: String) -> void:
	##Save the data to the resource file.
	ResourceSaver.save(stats, path)
	pass

##This class handles the player characters in the game.
#The class should have the name of the character, the stats, the equipment it has, and the skills it knows
#Stats
