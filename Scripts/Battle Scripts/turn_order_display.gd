extends Control
class_name TurnOrderDisplay

@onready var order_display = $MarginContainer/Border/IconOrder
@onready var b_manager = $".."
var units: Array[Actor]
var unit_icons:= {}
var turn_order: Array[Actor]
var round: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_unit(actor: Actor, icon: Sprite2D):
	units.append(actor)
	unit_icons[actor] = icon.duplicate()


##Deletes unit from the display once turn is over.
func next_unit(actor: Actor):
	var index = turn_order.find(actor)
	var child = order_display.get_child(index)
	child.get_child(0).self_modulate = Color(1,1,1,1)
	child.visible = false
	if index == turn_order.size()-1:
		round += 1
		update_order()
	else:
		child = order_display.get_child(index + 1)
		child.get_child(0).self_modulate = Color(1.2,1.2,1.2,1)
	pass

##Calculates the turn order. This is called at the start of every round.
func update_order():
	turn_order = units.duplicate()
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
	for child in order_display.get_children():
		var icon = child.get_child(0)
		if unit_icons[turn_order[child.get_index()]]:
			icon.texture = unit_icons[turn_order[child.get_index()]].texture
			child.visible = true
		else:
			pass
	for child in order_display.get_children():
		if child.visible == true:
			child.get_child(0).self_modulate = Color(1.2,1.2,1.2,1)
			break
		else:
			pass
	b_manager.t_order = turn_order
