extends Movable
class_name Pullable

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func can_move(velocity):
	if !.can_move(velocity):
		print("a")
		return false
	var blocking_obj = .get_blocking_obj(velocity)
	if(blocking_obj == null):
		print("b")
		return false
	if(blocking_obj == Globals.player):
		if(blocking_obj.can_move(velocity)):
			print("c")
			return true
			
	print("d")
	return false
