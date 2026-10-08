class_name Actor extends Sprite2D

@export var stats: Stats
@export var is_player: bool
var living: bool = true

var target_scale: float = 1.0


##This section contains the functions that are responsible for managing the actor's data.
func load_stats(path: String) -> void:
	stats = load(path)
	is_player = stats.is_player

func save_stats(path: String) -> void:
	##Save the data to the resource file.
	ResourceSaver.save(stats, path)


##Functions that handle the gameplay.

func begin_turn():
	self.scale = Vector2(1.5,1.5)
	print(self)
	print("Turn Start")

func end_turn():
	self.scale = Vector2(1,1)

func take_damage(damage: int) -> void:
	stats.attributes["Health"] -= damage
	if stats.attributes["Health"] <= 0:
		stats.attributes["Health"] = 0
		print(stats.char_name + " Has been slain!")
		_death()

func regain_health(healing: int) -> void:
	stats.attributes["Health"] += healing
	if stats.attributes["Health"] >= stats.attributes["Max Health"]:
		stats.attributes["Health"] = stats.attributes["Max Health"]

func _death():
	self.visible = false
	living = false

##This class handles the player characters in the game.
#The class should have the name of the character, the stats, the equipment it has, and the skills it knows
#Stats
