class_name Utils

static func is_in_layer(object, layer):	
	return ((object.get_collision_layer () >> (layer-1)) % 2) == 1

static func merge_dict(target:Dictionary, patch:Dictionary) -> void:
	for key in patch:
		if target.has(key):
			var tv = target[key]
			if typeof(tv) == TYPE_DICTIONARY:
				merge_dict(tv, patch[key])
			else:
				target[key] = patch[key]
		else:
			target[key] = patch[key]

static func snap_2_grid(pos:Vector2) -> Vector2:
	pos -= Vector2.ONE * Globals.tileSize/2
	pos = pos.snapped(Vector2.ONE * Globals.tileSize)
	pos += Vector2.ONE * Globals.tileSize/2
	return pos
