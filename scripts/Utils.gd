class_name Utils

static func is_in_layer(object, layer):	
	return ((object.get_collision_layer () >> (layer-1)) % 2) == 1
