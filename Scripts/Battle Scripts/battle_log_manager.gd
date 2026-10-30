extends Node

var display: RichTextLabel
var text_log: Array[String]

func add_entry(info: String):
	text_log.append(info)

func update_display():
	display.visible = true
	while not text_log.is_empty():
		display.text = text_log[0]
		await get_tree().create_timer(1.5).timeout
		text_log.remove_at(0)
		await get_tree().create_timer(0.5).timeout
	display.text = ""
	display.visible = false
