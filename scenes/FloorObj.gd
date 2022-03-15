extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var outline = $Outline
onready var sprite = $Sprite

var is_activated = false
var color_percent = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Utils.snap_2_grid(position)
	pass # Replace with function body.


func _process(delta):
	pass

func _physics_process(delta):
	var yes = get_overlapping_areas()
	is_activated = yes.size() > 0
	
	
	var goal_color_percent = 0
	if is_activated:
		goal_color_percent = 1 
	color_percent = move_toward(color_percent, goal_color_percent, delta * 4)
		
	outline.modulate = Color.darkgray.linear_interpolate( Color.yellow, color_percent );
		
		
	pass
