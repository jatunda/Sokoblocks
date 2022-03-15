extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# List (one elem per frame)
#  dictionary <object, savedata >
#    Savedata is a dictionary of <param, value>
# So, in total: List< Dictionary <Object, Dictionary<param,value> > > 
var level_memory = []
var currentFrame = {}
var all_objs = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
func next_frame() -> void:
#	print("Saving frame (", level_memory.size(), ") : " , currentFrame)
	level_memory.append(currentFrame)
	currentFrame = {}
	
	pass
	
func save(object:Node, param_dict:Dictionary) -> bool:
	if(!all_objs.has(object)):
		all_objs.append(object)
	if(currentFrame == null):
		return false
	if not currentFrame.has(object):
		currentFrame[object] = param_dict
	else:
		Utils.merge_dict(currentFrame[object], param_dict)
	
	return true

func reset() -> void:
	for obj in all_objs:
		obj.save()
	next_frame()
	# copy first frame to end of undo stack
#	currentFrame = level_memory[0].duplicate(true)
#	level_memory.append(currentFrame)
	# set all positions to those positions
	load_frame(level_memory[0].duplicate(true))


func undo() -> void:
	if level_memory.size() == 0:
		return
		
	#pop most recent frame
	var undoFrame = level_memory[-1]
	if(level_memory.size() > 1):
		level_memory.pop_back()
	load_frame(undoFrame)
	pass
	
func load_frame(frame) -> void:
		# for each object
	for obj in frame:
		# for each key/value pair
		for param in frame[obj].keys():
			obj.set(param, frame[obj][param])
			# object.key = value
