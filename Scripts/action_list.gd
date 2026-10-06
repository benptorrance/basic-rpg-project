class_name ActionList extends Container


func _ready():
	$FightButton.grab_focus()


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


func _on_back_button_pressed(menu: String) -> void:
	match menu:
		"Fight":
			$"../FightList".visible = false
		"Skills":
			$"../SkillsList".visible = false
		"Items":
			$"../ItemsList".visible = false
		"Party":
			$"../PartyList".visible = false
