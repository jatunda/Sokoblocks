extends Pushable
class_name Player


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#export var angularSpeed = 1.0


onready var pickupDetector = $PickupDetection
export var spriteFrames : SpriteFrames;
var pulled_obj = null
var left_obj = null
var right_obj = null
var to_be_saved = []

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	sprite.frames = spriteFrames;
	Globals.player = self;
	pass # Replace with function body.


func _physics_process(delta):
	for body in pickupDetector.get_overlapping_areas():
		if Utils.is_in_layer(body, Enums.LAYER_NAMES.Pickups):
			process_pickup(body.pickupType)
			body.queue_free()
			pass
#			body.destroy();

func process_pickup(pickupType):
	print("pickupType: %s (%s)" % [pickupType, Enums.PICKUP_TYPE.keys()[pickupType]])
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_reset"):
		save()
		SaveManager.reset()
		return
	if Input.is_action_just_pressed("game_undo"):
		SaveManager.undo()
		return	
	
	
	var velocity = get_movement_input();
	.try_move(velocity)
		
func get_movement_input():
	
	var velocity  = Vector2.ZERO	
	
	if Input.is_action_pressed("ui_left") || Input.is_action_just_pressed("ui_left"):
		velocity += Vector2.LEFT
	if Input.is_action_pressed("ui_right") || Input.is_action_just_pressed("ui_right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("ui_up") || Input.is_action_just_pressed("ui_up"):
		velocity += Vector2.UP
	if Input.is_action_pressed("ui_down") || Input.is_action_just_pressed("ui_down"):
		velocity += Vector2.DOWN
	if velocity.y != 0:
		velocity.x = 0
	
	velocity = velocity * Globals.tileSize
	return velocity
	
func move(velocity:Vector2, recurse:bool=true) ->void:
	.move(velocity)
	pulled_obj = get_blocking_obj(-velocity) as Pullable
	if(pulled_obj != null):
		pulled_obj.try_move(velocity)
		
	right_obj = get_blocking_obj(velocity.rotated(PI/2)) as Sideable
	if(right_obj != null):
		right_obj.try_move(velocity)
	left_obj = get_blocking_obj(velocity.rotated(-PI/2)) as Sideable
	if(left_obj != null):
		left_obj.try_move(velocity)
	save()
	SaveManager.next_frame()

	

	
func save():
	for obj in to_be_saved:
		obj.save()
	to_be_saved = []
	.save()
	if(pushed_obj != null):
		pushed_obj.save()
		to_be_saved.append(pushed_obj)
	if(pulled_obj != null):
		pulled_obj.save()
		to_be_saved.append(pulled_obj)
	if(left_obj != null):
		left_obj.save()
		to_be_saved.append(left_obj)
	if(right_obj != null):
		right_obj.save()
		to_be_saved.append(right_obj)



