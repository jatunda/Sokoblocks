extends Area2D


onready var outline = $Outline
onready var sprite = $Sprite

var is_activated = false
var color_percent = 0.0


func _ready():
	position = Utils.snap_2_grid(position)


func _physics_process(delta):
	var yes = get_overlapping_areas()
	is_activated = yes.size() > 0
	
	var goal_color_percent = 0
	if is_activated:
		goal_color_percent = 1 
	color_percent = move_toward(color_percent, goal_color_percent, delta * 4)
		
	outline.modulate = Color.darkgray.linear_interpolate( Color.yellow, color_percent );
		

func className():
	return Enums.CLASS_NAME.FloorObj;
