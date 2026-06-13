extends Node2D

var platform = preload("res://platform.tscn")
var width

func _ready():
	width =  get_viewport_rect().size.x
	randomize()
	var y = 0
	while y > -3000:
		var new_platform = platform.instantiate()
		new_platform.Transform2D.Vector2(randf_range(-width/2,width*2),y))
		add_child(new_platform)
		y-= randf_range(10, 210)
	pass
