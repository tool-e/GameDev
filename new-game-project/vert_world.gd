extends Node2D

@export var scene_to_instantiate: PackedScene
var width = 400
@onready var player: Player = $PLAYER/Player
@onready var win_screen: ColorRect = $Win/ColorRect
@onready var frog: Frog = $MOBS/Frog
var prev_position

func _ready():
	randomize()
	var y = 0  
	while y > -5000:
		var new_platform = scene_to_instantiate.instantiate()
		var rngesus_plat = scene_to_instantiate.instantiate()
		var offset = randf_range(-125,125)
		if prev_position == null:
			new_platform.position = Vector2(randf_range(-width , width),y)
			prev_position = new_platform.position
		else:
			if prev_position.x + offset >= width:
				prev_position.x -= offset
			if prev_position.x - offset < -width:
				prev_position.x += offset
			else:
				prev_position.x = prev_position.x + offset
			new_platform.position = Vector2(prev_position.x ,y)
			rngesus_plat.position = Vector2(randf_range(-width , width), y + offset)
		add_child(new_platform)
		add_child(rngesus_plat)
		y-= randf_range(100,125)

	pass
	
	win_screen.hide()

func win_game() -> void:
	if is_instance_valid(frog) and is_instance_valid(player):	frog.queue_free()
	player.set_physics_process(false)
	
	win_screen.show()
	
func _process(_delta: float) -> void:
	if player.position.y < -5000:
		win_game()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_again_pressed() -> void:
	Utils.LoadGame()
	get_tree().change_scene_to_file("res://vert_world.tscn")
