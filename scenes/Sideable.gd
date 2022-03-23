extends Pushable
class_name Sideable





func _ready():
	._ready()

# TODO: behavior when two blocks end up in same space. 
# a sideable and a PushableRight/PushableLeft can end up in the same space. 
# Need to bespoke program functionality for this. 
# solution: Sideable does not move, PushableLeft/Right does move. 
# This allows player to still actually move. 


func className():
	return Enums.CLASS_NAME.Sideable;
