extends NinePatchRect
class_name ActionMenu 

@onready var page_cont_1: Control
@onready var page_cont_2: Control
@onready var page_cont_3: Control
@onready var page_cont_4: Control
@onready var sel_page: int
var allies: Array[Actor]

func _load(array: Array[Actor]) -> void:
	allies = array
	populate_menu("Fight")

func populate_menu(menu: String) -> void:
	sel_page = 0
	match menu:
		"Fight":
			page_cont_1 = $FightActionList/ListLayout/PageContainer/Player1Pages
			page_cont_2 = $FightActionList/ListLayout/PageContainer/Player2Pages
			page_cont_3 = $FightActionList/ListLayout/PageContainer/Player3Pages
			page_cont_4 = $FightActionList/ListLayout/PageContainer/Player4Pages
		"Skills":
			page_cont_1 = null
		"Items":
			page_cont_1 = null
	for x in range(4):
		var page_index = 0
		var cur_page: Control
		match x:
			0:
				cur_page = page_cont_1.get_child(page_index)
				for action in allies[0].stats.base_actions:
					if cur_page.get_children().size() < 8:
						cur_page.add_button(action)
					else:
						add_page(1)
						page_index += 1
						cur_page = page_cont_1.get_child(page_index)
						cur_page.add_button(action)
			1:
				cur_page = page_cont_2.get_child(page_index)
				for action in allies[1].stats.base_actions:
					if cur_page.get_children().size() < 8:
						cur_page.add_button(action)
					else:
						add_page(2)
						page_index += 1
						cur_page = page_cont_2.get_child(page_index)
						cur_page.add_button(action)
			2:
				cur_page = page_cont_3.get_child(page_index)
				for action in allies[2].stats.base_actions:
					if cur_page.get_children().size() < 8:
						cur_page.add_button(action)
					else:
						add_page(3)
						page_index += 1
						cur_page = page_cont_3.get_child(page_index)
						cur_page.add_button(action)
			3:
				cur_page = page_cont_4.get_child(page_index)
				for action in allies[3].stats.base_actions:
					if cur_page.get_children().size() < 8:
						cur_page.add_button(action)
					else:
						add_page(4)
						page_index += 1
						cur_page = page_cont_4.get_child(page_index)
						cur_page.add_button(action)

func add_page(page_num: int)-> void:
	var new_page = Page.new()
	new_page.visible = false
	new_page.columns = 2
	new_page.set_anchors_preset(PRESET_FULL_RECT)
	match page_num:
		1:
			page_cont_1.add_child(new_page)
		2:
			page_cont_2.add_child(new_page)
		3:
			page_cont_3.add_child(new_page)
		4:
			page_cont_4.add_child(new_page)

##This function handles moving between the existing pages after they have been
##populated.
func button_handler(next: bool) -> void:
	page_cont_4.get_child(sel_page).visible = false
	if next == true:
		if sel_page +1 < page_cont_4.get_child_count():
			sel_page += 1
		else:
			sel_page = 0
	else:
		if sel_page != 0:
			sel_page -= 1
		else:
			sel_page = page_cont_4.get_child_count() - 1
	page_cont_4.get_child(sel_page).visible = true
