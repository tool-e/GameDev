extends Node2D

@export var scene_to_instantiate: PackedScene
var width = 500

func _ready():
	randomize()
	var y = 0  
	while y > -3000:
		var new_platform = scene_to_instantiate.instantiate()
		new_platform.position = Vector2(randf_range(-width/2,width*2),y)
		add_child(new_platform)
		y-= randf_range(10, 75)

	pass
	
	
