class_name ActionList extends Container

var prev_focus: Control = null
var page_cont: Control
@onready var b_scene = get_tree().current_scene
signal state_change

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
	state_change.emit(1)
	for child in page_cont.get_children():
		if child == page_cont.get_child(player_num):
			child.visible = true
			child.get_child(0).get_child(0).grab_focus()
		else:
			child.visible = false

func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_ESCAPE && b_scene.menu_state == BattleScene.STATES.ACT_LIST:
		var children = get_parent().get_children()
		for child in children:
			if child.visible && child != self:
				child.visible = false
				match child.name:
					"FightActionList":
						$FightButton.grab_focus()
					"SkillsActionList":
						$SkillsButton.grab_focus()
		await get_tree().create_timer(0.1).timeout
		state_change.emit(0)
