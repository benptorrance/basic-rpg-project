class_name ActionList extends Container


func _ready():
	$FightButton.grab_focus()


func _on_button_pressed(btn_name: String) -> void:
	match btn_name:
		"Fight":
			$"../FightList".visible = true
			$"../FightList/FightCont/BasicAttack".grab_focus()
		"Defend":
			pass
		"Skills":
			$"../SkillsList".visible = true
			$"../SkillsList/SkillsCont/SkillsButton".grab_focus()
		"Items":
			$"../ItemsList".visible = true
			$"../ItemsList/ItemCont/ItemsButton".grab_focus()
		"Party":
			$"../PartyList".visible = true
			$"../PartyList/PartyCont/PartyButton".grab_focus()
		"Flee":
			pass


func _on_back_button_pressed(menu: String) -> void:
	match menu:
		"Fight":
			$"../FightList".visible = false
			$FightButton.grab_focus()
		"Skills":
			$"../SkillsList".visible = false
			$SkillsButton.grab_focus()
		"Items":
			$"../ItemsList".visible = false
			$ItemsButton.grab_focus()
		"Party":
			$"../PartyList".visible = false
			$PartyButton.grab_focus()
