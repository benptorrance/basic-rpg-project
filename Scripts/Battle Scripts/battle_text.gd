extends Control


func _ready() -> void:
	BattleLogManager.background = get_child(0)
	BattleLogManager.display = get_child(1)


##Clears reference to this node from the BattleLogManager autoload
##so that there is not a dangling reference.
func _exit_tree() -> void:
	if BattleLogManager.background == get_child(0):
		BattleLogManager.background = null
	if BattleLogManager.display == get_child(1):
		BattleLogManager.display = null
