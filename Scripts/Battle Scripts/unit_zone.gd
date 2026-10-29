class_name UnitZone extends Control

@onready var units: Array
signal target_selected

func _ready() -> void:
	for child in self.get_children():
		units.append(child)
		child.get_child(1).disabled = false

##Handles the targeting of the units within the zone.
func unit_selection(sel_actor: Actor):
	##Upon being called it sets the currently selected actor's Targeting Icon to visible
	sel_actor.get_child(1).grab_focus()
	var targets = await target_selected
	for unit in units:
		unit.get_child(0).visible = false
	return targets

func _selector_pressed(btn_index: int):
	var targets: Array[int]
	targets.append(btn_index)
	target_selected.emit(targets)

##First sets the targeting icons to not visible, then selects the correct
func _change_focus(btn_index: int) -> void:
	for unit in units:
		unit.get_child(0).visible = false
	match btn_index:
		0:
			units[0].get_child(0).visible = true
		1:
			units[1].get_child(0).visible = true
		2:
			units[2].get_child(0).visible = true
		3:
			units[3].get_child(0).visible = true
	
