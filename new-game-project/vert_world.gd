extends Node2D

@export var scene_to_instantiate: PackedScene
var width = 400
@onready var player: Node2D = $PLAYER
var prev_position

func _ready():
	randomize()
	var y = 0  
	while y > -3000:
		var new_platform = scene_to_instantiate.instantiate()
		if prev_position == null:
			new_platform.position = Vector2(randf_range(-width , width),y)
			prev_position = new_platform.position
		else:
			var offset = randf_range(-150,150)
			if prev_position.x + offset >= width:
				prev_position.x -= offset
			if prev_position.x - offset < -width:
				prev_position.x += offset
			else:
				prev_position.x = prev_position.x + offset
			new_platform.position = Vector2(prev_position.x ,y)
		add_child(new_platform)
		y-= randf_range(100,125)
		
	pass
	
