extends Node

var display: RichTextLabel
var background: NinePatchRect
var text_log: Array[String]
signal log_cleared

func add_entry(info: String):
	text_log.append(info)

func update_display():
	background.visible = true
	display.visible = true
	while not text_log.is_empty():
		display.text = text_log[0]
		await get_tree().create_timer(1.0).timeout
		text_log.pop_front()
	display.text = ""
	display.visible = false
	background.visible = false
	log_cleared.emit()
