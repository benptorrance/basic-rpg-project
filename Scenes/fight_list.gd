extends NinePatchRect

var focused_button: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _set_focus() -> void:
	match focused_button:
		"BasicAttack":
			$FightCont/BasicAttack.get_focus()
	pass # Replace with function body.

func _remember_focus(b_num: int) -> void:
	match b_num:
		1:
			focused_button = "BasicAttack"
	pass
