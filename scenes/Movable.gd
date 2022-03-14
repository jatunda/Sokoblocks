extends Area2D
class_name Movable

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sprite = $AnimatedSprite
onready var ray = $RayCast2D
onready var tween = $Tween


var moving_dir = Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	position = snap_2_grid(position)
	save()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func try_move(velocity):
	if(can_move(velocity)):
		move(velocity)


func can_move(velocity:Vector2, recurse:bool=true) -> bool:
	return !is_moving() && !tween.is_active()
	

func move(deltaPos:Vector2, recurse:bool=true)->void: 

	var goalPos = position + deltaPos
	goalPos = snap_2_grid(goalPos)
	tween.interpolate_property(self, "position", position, goalPos,
		1.0/Globals.movementSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	moving_dir = deltaPos
	pass
	
func is_moving() -> bool:
	return moving_dir != Vector2.ZERO
	
func is_moving_in_direction(vector) -> bool:
	return is_moving() && abs(vector.angle_to(moving_dir)) < 1.0


func snap_2_grid(pos:Vector2) -> Vector2:
	pos -= Vector2.ONE * Globals.tileSize/2
	pos = pos.snapped(Vector2.ONE * Globals.tileSize)
	pos += Vector2.ONE * Globals.tileSize/2
	return pos
		
		
func get_blocking_obj(velocity):
	ray.cast_to = velocity
	ray.force_raycast_update()
	if !ray.is_colliding():
#		print("%s detected %s" % [self, "nothing"])
		return null
#	print("%s detected %s" % [self, ray.get_collider()])
	return ray.get_collider()


func _on_Tween_tween_completed(object, key):
	if(object != self):
		return
	if(key == NodePath(":position")):
		moving_dir = Vector2.ZERO
	
		
func save() -> void:
	var save_data = {
		"position":position
	}
	SaveManager.save(self, save_data)
	pass
	
