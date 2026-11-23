extends Resource
class_name ImageData

var unit_id: StringName
var sprite:= Sprite2D.new()
var icon:= Sprite2D.new()

const UNIT_SPRITES:= {
	"warrior": "res://Assets/Unit Sprites/Players/Sprites/test_warrior.png",
	"mage": "res://Assets/Unit Sprites/Players/Sprites/test_mage.png",
	"priest": "res://Assets/Unit Sprites/Players/Sprites/test_priest.png",
	"ranger": "res://Assets/Unit Sprites/Players/Sprites/test_ranger.png",
}
const UNIT_ICONS:={
	"warrior": "res://Assets/Unit Sprites/Players/Icons/test_warrior_icon.png",
	"mage": "res://Assets/Unit Sprites/Players/test_ally.png",
	"priest": "res://Assets/Unit Sprites/Players/test_ally.png",
	"ranger": "res://Assets/Unit Sprites/Players/test_ally.png",
}

func load_image(unit_id: StringName):
	if UNIT_SPRITES.has(unit_id) && UNIT_ICONS.has(unit_id):
		var images
		sprite.texture = load(UNIT_SPRITES[unit_id])
		icon.texture = load(UNIT_ICONS[unit_id])
		images = [sprite, icon]
		return images
	if UNIT_SPRITES.has(unit_id) == false && UNIT_ICONS.has(unit_id):
		push_warning("Unit is missing a Sprite!")
	if UNIT_SPRITES.has(unit_id) && UNIT_ICONS.has(unit_id) == false:
		push_warning("Unit is missing a Icon!")
	if UNIT_SPRITES.has(unit_id) == false && UNIT_ICONS.has(unit_id) == false:
		push_warning("Unit is missing both textures!")
