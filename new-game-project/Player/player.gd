class_name Player extends CharacterBody2D



const SPEED = 200.0


@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var anime: AnimatedSprite2D = $AnimatedSprite2D

#Handle direction and which way player looks	
var direction := Input.get_axis("ui_left", "ui_right")
func MOVE() -> void:
	if direction == -1: anime.flip_h = true
	elif direction == 1: anime.flip_h = false
	self.velocity.x = direction * SPEED
	 

#States the player can be in at any given time
func RUN() -> void:
	if direction == -1: anime.flip_h = true
	elif direction == 1: anime.flip_h = false
	velocity.x = direction * SPEED
	anim.play("Run")

func IDLE() -> void:
	velocity.x = move_toward(velocity.x, 0, SPEED)
	anim.play("Idle")

func JUMP() -> void:
	MOVE()
	velocity.y = Game.JUMP_VELOCITY
	anim.play("Jump")
	
func FALL() -> void:
	MOVE()
	anim.play("Fall")

var curr_state
enum States {
	IDLE,
	RUN,
	JUMP,
	FALL,
	AIR_STRAFE
}
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		curr_state = States.RUN
	elif is_on_floor():
		curr_state = States.IDLE
	if Input.is_action_just_pressed("ui_accept") and is_on_floor(): curr_state = States.JUMP
	if velocity.y > 0: curr_state = States.FALL
	
	
	match curr_state:
		#States.JUMP:
			#BaseState.JUMP()
		#States.FALL:
			#BaseState.FALL()
		States.RUN:
			RUN()
			#if direction == -1: anime.flip_h = true
			#elif direction == 1: anime.flip_h = false
			#self.velocity.x = direction * SPEED
			#anim.play("Run")
		#States.AIR_STRAFE:
			#if direction == -1: anime.flip_h = true
			#elif direction == 1: anime.flip_h = false
			#velocity.x = direction * SPEED
		States.IDLE:
			IDLE()
	
	move_and_slide()	
	print(velocity.x)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	

	
	
	if Game.playerHP <= 0:
		queue_free()
		Game.playerHP = 1
		Utils.SaveGame()
		get_tree().change_scene_to_file("res://main.tscn")
