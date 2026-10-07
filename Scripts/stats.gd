extends Resource
class_name Stats

@export var char_name: String
@export var is_player: bool

##Holds
@export var attributes = {
	"Str":0,
	"Vit":0,
	"Dex":0,
	"Wis":0,
	"Luk":0,
	"Health":0,
	"Max Health":0,
	"Phys Attack": 0,
	"Armor": 0,
	"Magi Attack": 0,
	"Warding": 0,
	}

@export var s_resists = {
	"Poisoned Resist": 0,
	"Bleed Resist": 0,
	"Stun Resist": 0,
	"Slow Resist": 0,
	"Armor Sunder Resist": 0,
	"Ward Sunder Resist": 0,
	"Silence Resist": 0,
	"Disarm": 0,
	"Paralisis Resist": 0,
	"Petrify Resist": 0,
	"Curse Resist": 0,
	"Burn Resist": 0,
	"Disease Resist": 0,
}

@export var e_resists = {
	"Fire Resist": 0,
	"Ice/Water Resist": 0,
	"Wind Resist": 0,
	"Earth Resist": 0,
	"Lightning Resist": 0,
	"Nature Resist": 0,
	"Arcane Resist": 0,
	"Dark Resist": 0,
	"Holy Resist": 0,
}
##A dictionary that holds the equipment slots that a character may have an item equipped in.
@export var equipment = {
	"Head": null,
	"Body": null,
	"Hands": null,
	"Legs": null,
	"Main Hand": null,
	"Off Hand": null,
	"Accessory": null,
}

##Holds the list of skills the character has access to.
@export var skills = {}
