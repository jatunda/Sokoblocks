extends Movable
class_name Pullable

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func can_move(velocity:Vector2, recurse:bool=true):
	if !.can_move(velocity):
		return false
	var blocking_obj = .get_blocking_obj(velocity)
	if(blocking_obj == null):
		return false

	if(blocking_obj.get_instance_id() == Globals.player.get_instance_id()):
#	var player = blocking_obj as Player;
#	if(player != null):
		var player = blocking_obj
		if(player.is_moving_in_direction(velocity) || player.can_move(velocity)):
			return true
			
	return false
