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
		"Defend":
			pass
		"Skills":
			$"../SkillsActionList".visible = true
			page_cont = $"../SkillsActionList/ListLayout/PageContainer"
		"Items":
			$"../ItemActionList".visible = true
			page_cont = $"../ItemActionList/ListLayout/PageContainer"
		"Party":
			pass
		"Flee":
			pass
	state_change.emit(true, 1)
	for child in page_cont.get_children():
		if child == page_cont.get_child(player_num):
			child.visible = true
			print(child.get_child(0).get_child(0))
			child.get_child(0).get_child(0).grab_focus()
		else:
			child.visible = false

func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_ESCAPE && b_scene.menu_layer.back() == BattleScene.ACTIVE_LAYERS.ACT_LIST && event.pressed:
		var children = get_parent().get_children()
		for child in children:
			if child.visible && child != self:
				child.visible = false
				match child.name:
					"SkillsActionList":
						$SkillsButton.grab_focus()
					"ItemActionList":
						$ItemsButton.grab_focus()
		state_change.emit(false)
		get_viewport().set_input_as_handled()
