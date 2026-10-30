extends RichTextLabel


func _ready() -> void:
	BattleLogManager.display = self


##Clears reference to this node from the BattleLogManager autoload
##so that there is not a dangling reference.
func _exit_tree() -> void:
	if BattleLogManager.display == self:
		BattleLogManager.display = null
