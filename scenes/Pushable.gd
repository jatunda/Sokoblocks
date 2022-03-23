extends Movable
class_name Pushable


var pushed_obj = null
var pushed_dir = Vector2.ZERO

func _ready():
	._ready()
	
	
func can_move(velocity:Vector2, recurse: bool=true) -> bool:
	if velocity == Vector2.ZERO:
		return false
	if !.can_move(velocity):
		return false
	var blocking_obj = .get_blocking_obj(velocity)
	if(blocking_obj == null):
		return true
	if(recurse):
		if(blocking_obj as Pushable != null and (blocking_obj.className() != Enums.CLASS_NAME.Sideable)):
#			print(self, blocking_obj, blocking_obj.can_move(velocity, false))
			if(blocking_obj.can_move(velocity, false)):
				return true
	return false
	

func move(velocity:Vector2, recurse:bool = true) -> void:
	var blocking_obj = .get_blocking_obj(velocity) as Pushable
	if(recurse && blocking_obj != null):
		blocking_obj.move(velocity, false)
		pushed_obj = blocking_obj
	else:
		pushed_obj = null
	pushed_dir = velocity
	.move(velocity, false)
	
	
func is_pushed_in_direction(direction:Vector2):
	return abs(direction.angle_to(pushed_dir)) < 1.0
	
	
func className():
	return Enums.CLASS_NAME.Pushable;
