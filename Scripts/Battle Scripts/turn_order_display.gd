extends Control
class_name TurnOrderDisplay

var units: Array[Actor]
var unit_icons:= {}
var turn_order: Array[Actor]
var round: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_unit(actor: Actor, icon: Sprite2D):
	units.append(actor)
	unit_icons[actor] = icon

##Deletes unit from the display once turn is over.
func next_unit():
	pass

##Calculates the turn order. This is called at the start of every round.
func update_order():
	turn_order = units
	for i in range(0, 8):
		for x in range(i+1,8):
			if turn_order[i].stats.attributes.Dex < turn_order[x].stats.attributes.Dex:
				var temp = turn_order[i]
				turn_order[i] = turn_order[x]
				turn_order[x] = temp
			#If speeds are equal, swap 50% of the time.
			if turn_order[i].stats.attributes.Dex == turn_order[x].stats.attributes.Dex:
				if randf() > 0.5:
					var temp = turn_order[i]
					turn_order[i] = turn_order[x]
					turn_order[x] = temp
	return turn_order
