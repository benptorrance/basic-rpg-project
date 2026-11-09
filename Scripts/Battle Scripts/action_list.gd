class_name ActionList extends Container

var prev_focus: Control = null

func _ready():
	$FightButton.grab_focus()


func _on_button_pressed(btn_name: String) -> void:
	var player = get_tree().current_scene.sel_actor
	var players = get_tree().current_scene.allies
	var player_num = players.find(player)
	match btn_name:
		"Fight":
			$"../FightActionList".visible = true
		"Skills":
			$"../SkillsList".visible = true
			$"../SkillsList/SkillsCont/Skill1".grab_focus()
		"Items":
			$"../ItemsList".visible = true
			$"../ItemsList/ItemCont/Item1".grab_focus()
		"Party":
			$"../PartyList".visible = true
			$"../PartyList/PartyCont/Party1".grab_focus()
		"Flee":
			pass
	match player_num:
		0:
			$"../FightActionList/ListLayout/PageContainer/Player2Pages".visible = true
			$"../FightActionList/ListLayout/PageContainer/Player1Pages/Page".grab_focus()
		1:
			$"../FightActionList/ListLayout/PageContainer/Player2Pages".visible = true
			$"../FightActionList/ListLayout/PageContainer/Player2Pages/Page".grab_focus()
		2:
			$"../FightActionList/ListLayout/PageContainer/Player3Pages".visible = true
			$"../FightActionList/ListLayout/PageContainer/Player3Pages/Page".grab_focus()
		3:
			$"../FightActionList/ListLayout/PageContainer/Player4Pages".visible = true
			$"../FightActionList/ListLayout/PageContainer/Player4Pages/Page".grab_focus()


func _on_back_button_pressed(menu: String) -> void:
	match menu:
		"Fight":
			$"../FightActionList".visible = true
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
