extends Node2D


var cherry = preload("res://Collectibles/cherry.tscn")


func _on_timer_timeout() -> void:
	var cherryTemp = cherry.instantiate()
	var rng = RandomNumberGenerator.new()
	var ranint = rng.randi_range(200, 400)
	#cherryTemp.position = Vector2(ranint, 300)
	add_child(cherryTemp)
	cherryTemp.position = Vector2(ranint, 0)
	
	
