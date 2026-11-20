extends Resource
class_name ActiveParty

@export var party_members: Array[PARTY]
var paths: Array[String]

enum PARTY {
	WARRIOR,
	MAGE,
	PRIEST,
	RANGER
}

func load_active():
	for member in party_members:
		match member:
			PARTY.WARRIOR:
				paths.append("res://Content/Entities/Players/warrior.tres")
			PARTY.MAGE:
				paths.append("res://Content/Entities/Players/mage.tres")
			PARTY.PRIEST:
				paths.append("res://Content/Entities/Players/priest.tres")
			PARTY.RANGER:
				paths.append("res://Content/Entities/Players/ranger.tres")
