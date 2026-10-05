class_name BattleCharacter extends Resource

@export var char_name: String

@export var stats = {
	"cur_health":0,
	"max_health":0,
	"Str":0,
	"Vit":0,
	"Dex":0,
	"Wis":0,
	"Luk":0
	}

func _init() -> void:
	for i in (range(1,7)):
		if stats.keys()[i] == "max_health":
			stats[stats.keys()[i]] = randi() % 801 + 200
		else:
			stats[stats.keys()[i]] = randi() % 91 + 10
	stats["cur_health"] = stats["max_health"]
	print(stats)
