extends NinePatchRect
class_name ActionMenu 

@onready var page_cont_1: Node
@onready var page_cont_2: Node
@onready var page_cont_3: Node
@onready var page_cont_4: Node
@onready var sel_page: int
var allies: Array[Actor]

func _load(array: Array[Actor]) -> void:
	allies = array
	populate_menu("Fight")

func populate_menu(menu: String) -> void:
	sel_page = 0
	var page_index = 0
	var i = 0
	match menu:
		"Fight":
			page_cont_1 = $FightActionList/ListLayout/PageContainer
			page_cont_2 = $FightActionList/ListLayout/PageContainer2
			page_cont_3 = $FightActionList/ListLayout/PageContainer3 
			page_cont_4 = $FightActionList/ListLayout/PageContainer4
		"Skills":
			page_cont_1 = null
		"Items":
			page_cont_1 = null
	for x in range(4):
		match x:
			0:
				
				for action in allies[0].stats.base_actions:
					var cur_page = page_cont_1.get_child(page_index)
					if cur_page.get_children().size() < 8:
						cur_page.add_button(action)
						
						i += 1
					elif button_num !=0:
						add_page()
						page_index += 1
			1:
				while button_num > 0:
					var cur_page = page_cont_2.get_child(page_index)
					print(i)
					if cur_page.get_children().size() < 8 && button_num > 0:
						cur_page.add_button(buttons[i])
						button_num -= 1
						i += 1
					elif button_num !=0:
						add_page()
						page_index += 1
			2:
				while button_num > 0:
					var cur_page = page_cont_3.get_child(page_index)
					print(i)
					if cur_page.get_children().size() < 8 && button_num > 0:
						cur_page.add_button(buttons[i])
						button_num -= 1
						i += 1
					elif button_num !=0:
						add_page()
						page_index += 1
			3:
				while button_num > 0:
					var cur_page = page_cont_4.get_child(page_index)
					print(i)
					if cur_page.get_children().size() < 8 && button_num > 0:
						cur_page.add_button(buttons[i])
						button_num -= 1
						i += 1
					elif button_num !=0:
						add_page()
						page_index += 1
	pass

func add_page()-> void:
	var new_page = Page.new()
	new_page.visible = false
	new_page.columns = 2
	new_page.set_anchors_preset(PRESET_FULL_RECT)
	page_cont.add_child(new_page)
	print(page_cont.get_children())
	pass

##This function handles moving between the existing pages after they have been
##populated.
func button_handler(next: bool) -> void:
	page_cont.get_child(sel_page).visible = false
	if next == true:
		if sel_page +1 < page_cont.get_child_count():
			sel_page += 1
		else:
			sel_page = 0
	else:
		if sel_page != 0:
			sel_page -= 1
		else:
			sel_page = page_cont.get_child_count() - 1

	page_cont.get_child(sel_page).visible = true
