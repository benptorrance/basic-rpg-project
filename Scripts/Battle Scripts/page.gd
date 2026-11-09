extends GridContainer
class_name Page

##Take Combat Action and then make a button for it. The button should be able to submit the action.
func add_button(action: CombatAction) -> void:
	var new_button = Button.new()
	new_button.text = action.action_name
	new_button.button_down.connect(get_node("/root/BattleScene").fetch_action.bind())
	new_button.size_flags_horizontal = SIZE_EXPAND + SIZE_SHRINK_CENTER
	add_child(new_button)
	pass

func sel_button() -> void:
	print(get_child(0))
	get_child(0).grab_focus()
