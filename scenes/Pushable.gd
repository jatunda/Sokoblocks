extends Movable
class_name Pushable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pushed_obj = null

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	pass # Replace with function body.
	
	
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
			# TODO BUGFIX: can push sidable like a normal pushable
			# This bugfix probably includes a refactor so that checking for type is based on global Classes enum
			if(blocking_obj.can_move(velocity, false)):
				return true
	return false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func move(velocity:Vector2, recurse:bool = true) -> void:
	var blocking_obj = .get_blocking_obj(velocity) as Pushable
	if(recurse && blocking_obj != null):
		blocking_obj.move(velocity, false)
		pushed_obj = blocking_obj
	else:
		pushed_obj = null
	.move(velocity, false)
	
func className():
	return Enums.CLASS_NAME.Pushable;
