extends Pushable
class_name Sideable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# TODO: behavior when two blocks end up in same space. 
# a sideable and a PushableRight/PushableLeft can end up in the same space. 
# Need to bespoke program functionality for this. 
# Most likely solution: Sideable does not move, PushableLeft/Right does move. 
# This allows player to still actually move. 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
