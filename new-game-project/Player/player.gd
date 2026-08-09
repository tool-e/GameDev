class_name Player extends CharacterBody2D



@onready var BaseState: BaseState = %BaseState


func LogState(state) -> String:
	match state:
		States.JUMP:
			return "State: JUMP"
		States.FALL:
			return "State: FALL"
		States.RUN:
			return "State: RUN"
		States.IDLE:
			return "State: IDLE"
	return "ERROR"


##States the player can be in at any given time
enum States {
	IDLE,
	RUN,
	JUMP,
	FALL
}
var curr_state = States.IDLE
var direction


func _physics_process(delta: float) -> void:
	# Handle States
	BaseState.RUN()
	BaseState.IDLE()
	BaseState.JUMP()
	BaseState.FALL(delta)
			
	#print(LogState(curr_state))
	
	move_and_slide()	
	
	
		

func _process(_delta:float) -> void:
	if position.y > 1000 or Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://lose.tscn")
