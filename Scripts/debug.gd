extends Node




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_R:
				get_tree().reload_current_scene()
			KEY_Q:
				get_tree().quit()
			KEY_F11:
				get_window().mode = Window.MODE_FULLSCREEN
