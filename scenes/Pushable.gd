extends Movable
class_name Pushable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func can_move(velocity):
	if velocity == Vector2.ZERO:
		return false
	if !.can_move(velocity):
		return false
	var blocking_obj = .get_blocking_obj(velocity)
	if(blocking_obj == null):
		return true
	if(blocking_obj as Pushable != null):
		if(blocking_obj.can_move(velocity)):
			return true
			
	return false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func move(velocity):
	var blocking_obj = .get_blocking_obj(velocity) as Pushable
	if(blocking_obj != null):
		blocking_obj.move(velocity)
	.move(velocity)
