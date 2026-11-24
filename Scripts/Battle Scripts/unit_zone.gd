class_name UnitZone extends Control

@onready var units: Array
@onready var prev_button: String
@onready var b_scene = get_tree().current_scene
signal target_selected
signal state_change

func _ready() -> void:
	##Prevents mouse input when the zone is not running unit_selection
	for child in self.get_children():
		units.append(child)
		child.get_child(1).disabled = false
		child.get_child(1).mouse_filter = Control.MOUSE_FILTER_IGNORE

##Handles the targeting of the units within the zone.
func unit_selection(sel_actor: Actor):
	##Upon being called it sets the currently selected actor's Targeting Icon to visible
	prev_button = get_viewport().gui_get_focus_owner().get_path()
	state_change.emit(true, 2)
	sel_actor.get_child(1).grab_focus()
	
	for unit in units:
		unit.get_child(1).mouse_filter = Control.MOUSE_FILTER_STOP
	
	var targets = await target_selected
	for unit in units:
		unit.get_child(0).visible = false
		unit.get_child(1).mouse_filter = Control.MOUSE_FILTER_IGNORE
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

func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_ESCAPE && b_scene.menu_layer.back() == BattleScene.ACTIVE_LAYERS.TARGETING && event.pressed:
		for unit in units:
			if unit.get_child(0).visible:
				unit.get_child(0).visible = false
				unit.get_child(1).mouse_filter = Control.MOUSE_FILTER_IGNORE
				get_node(prev_button).grab_focus()
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		state_change.emit(false)
		get_viewport().set_input_as_handled()
