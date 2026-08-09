extends Node2D

@export var scene_to_instantiate: PackedScene
var width = 500
@onready var player: Player = $PLAYER/Player
@onready var win_screen: ColorRect = $Win/ColorRect
@onready var frog: Frog = $MOBS/Frog

func _ready():
	randomize()
	var y = 0  
	while y > -5000:
		var new_platform = scene_to_instantiate.instantiate()
		new_platform.position = Vector2(randf_range(-width/2,width*2),y)
		var old_x = new_platform.position.x
		if(new_platform.position.x - old_x > 50 && new_platform.position.x != old_x):
			new_platform.position.x = old_x + 15
		add_child(new_platform)
		y-= randf_range(10, 60)
	
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
