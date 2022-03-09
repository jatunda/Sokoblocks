extends Area2D
class_name Movable

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sprite = $AnimatedSprite
onready var ray = $RayCast2D
onready var tween = $Tween
export var color: Color = Color.white



# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = color
	snap_to_grid()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func try_move(velocity):
	if(can_move(velocity)):
		move(velocity)

func can_move(velocity) -> bool:
	return !tween.is_active()
	

func move(deltaPos):
	tween.interpolate_property(self, "position", position, position + deltaPos,
		1.0/Globals.movementSpeed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pass
	


func snap_to_grid():
	position -= Vector2.ONE * Globals.tileSize/2
	position = position.snapped(Vector2.ONE * Globals.tileSize)
	position += Vector2.ONE * Globals.tileSize/2
		
		
func get_blocking_obj(velocity):
	ray.cast_to = velocity
	ray.force_raycast_update()
	if !ray.is_colliding():
		print("%s detected %s" % [self, "nothing"])
		return null
	print("%s detected %s" % [self, ray.get_collider()])
	return ray.get_collider()
