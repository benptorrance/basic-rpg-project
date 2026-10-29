extends RichTextLabel
class_name BattleText

var text_log: Array[String]

func _ready() -> void:
	update_display()

func add_entry(info: String):
	text_log.append(info)

func update_display():
	self.visible = true
	while not text_log.is_empty():
		self.text = text_log[0]
		await get_tree().create_timer(1.5).timeout
		text_log.remove_at(0)
		await get_tree().create_timer(0.5).timeout
	self.text = ""
	self.visible = false
