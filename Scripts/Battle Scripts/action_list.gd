class_name ActionList extends Container

var prev_focus: Control = null
var page_cont: Control

func _ready():
	$FightButton.grab_focus()


func _on_button_pressed(btn_name: String) -> void:
	var player = get_tree().current_scene.sel_actor
	var players = get_tree().current_scene.allies
	var player_num = players.find(player)
	match btn_name:
		"Fight":
			$"../FightActionList".visible = true
			page_cont = $"../FightActionList/ListLayout/PageContainer"
		"Skills":
			$"../SkillsActionList".visible = true
			page_cont = $"../SkillsActionList/ListLayout/PageContainer"
		"Items":
			pass
		"Party":
			pass
		"Flee":
			pass
	for child in page_cont.get_children():
		if child == page_cont.get_child(player_num):
			child.visible = true
			print(child.get_child(0).get_children())
			child.get_child(0).get_child(0).grab_focus()
		else:
			child.visible = false

func _on_back_button_pressed(menu: String) -> void:
	match menu:
		"Fight":
			$"../FightActionList".visible = true
			$FightButton.grab_focus()
		"Skills":
			$"../SkillsActionList".visible = true
			$SkillsButton.grab_focus()
		"Items":
			pass
		"Party":
			pass
