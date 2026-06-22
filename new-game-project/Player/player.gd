class_name Player extends CharacterBody2D



const SPEED = 200.0

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
	# Add the gravity.
	#if not is_on_floor():
		#self.velocity += get_gravity() * delta

	# Handle States
	direction = Input.get_axis("ui_left", "ui_right")
	BaseState.RUN()
	BaseState.IDLE()
	BaseState.JUMP()
	BaseState.FALL(delta)
	
	
	#match curr_state:
		#States.JUMP:
			##BaseState.JUMP()
			#self.velocity.y = Game.JUMP_VELOCITY
			#$AnimationPlayer.play("Jump")
		#States.FALL:
			#BaseState.FALL(delta)
		#States.RUN:
			#BaseState.RUN()
		#States.IDLE:
			#BaseState.IDLE()
			
	print(LogState(curr_state))
	
	move_and_slide()	

	
	#Player Death / Game Over
	if Game.playerHP <= 0:
		queue_free()
		Game.playerHP = 1
		Utils.SaveGame()
		get_tree().change_scene_to_file("res://main.tscn")
