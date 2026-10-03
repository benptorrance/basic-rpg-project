class_name ActionList extends Container



func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_ESCAPE:
				$"../FightList".visible = false
				$"../SkillsList".visible = false
				$"../ItemsList".visible = false
				$"../PartyList".visible = false



func _on_button_pressed(btn_name: String) -> void:
	match btn_name:
		"Fight":
			$"../FightList".visible = true
		"Defend":
			pass
		"Skills":
			$"../SkillsList".visible = true
		"Items":
			$"../ItemsList".visible = true
		"Party":
			$"../PartyList".visible = true
		"Flee":
			pass
