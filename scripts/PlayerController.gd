extends Pushable
class_name Player


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#export var angularSpeed = 1.0


onready var pickupDetector = $PickupDetection
export var spriteFrames : SpriteFrames;

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
	var velocity = get_input();
	.try_move(velocity)
		
func get_input():
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
	
func move(velocity):
	.move(velocity)
	var pull_obj = get_blocking_obj(-velocity) as Pullable
	if(pull_obj != null):
		pull_obj.try_move(velocity)
	

