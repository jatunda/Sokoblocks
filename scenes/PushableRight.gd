extends Pushable
class_name PushableRight


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var goes_left:bool=true
var rotation_radians = PI/2
var rotation_speedup = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	if(!goes_left):
		rotation_radians = -rotation_radians
	._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	._process(delta)
	var rotDelta = delta * 1.1
	if(!goes_left):
		rotDelta = -rotDelta
#	if(is_moving()):
#		rotation_speedup = 7
#	else:
#		rotation_speedup = move_toward(rotation_speedup, 1, delta*3)
	rotation_speedup = move_toward(rotation_speedup, 1, delta*4.5)

	rotDelta *= rotation_speedup
	sprite.rotation += rotDelta
		
		
	if(!is_moving()):
		var goalPos = Utils.snap_2_grid(position)	
		var distanceSqToPlayer = Globals.player.position.distance_squared_to(position)
		if(distanceSqToPlayer <= Globals.tileSize *Globals.tileSize * 1.1):
			var directionFromPlayer = Globals.player.position.direction_to(position)
			if(abs(directionFromPlayer.x) > abs(directionFromPlayer.y)):
				directionFromPlayer = Vector2(directionFromPlayer.x, 0)
			else:
				directionFromPlayer = Vector2(0, directionFromPlayer.y)
			goalPos += directionFromPlayer.normalized().rotated(rotation_radians) * Globals.tileSize / 8
		position = position.move_toward(goalPos, delta*60)
	pass


func can_move(velocity:Vector2, recurse: bool=true) -> bool:
	return .can_move(velocity.rotated(rotation_radians), recurse)
	
func move(velocity:Vector2, recurse:bool=true) -> void:
	rotation_speedup = 7
	.move(velocity.rotated(rotation_radians), false)
	
func save() -> void:
	.save()
	var param_dict = {
		"rotation_speedup": 1
	}
	SaveManager.save(self, param_dict)
