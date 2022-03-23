extends Pushable
class_name Swappable

func can_move(velocity:Vector2, recurse: bool=true) -> bool:
	return true
	
func move(velocity:Vector2, recurse:bool=true)->void:
	.move(-velocity, false)

func className():
	return Enums.CLASS_NAME.Swappable;
