extends CharacterBody2D



const SPEED = 300.0
const JUMP_VELOCITY = -1500

@onready var anim = $AnimationPlayer
@onready var anime = $AnimatedSprite2D

enum States {
	IDLE,
	RUN,
	JUMP,
	FALL
}
var curr_state = States.IDLE	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction: 
		curr_state = States.RUN
	else:
		curr_state = States.IDLE
	if Input.is_action_just_pressed("ui_accept") and is_on_floor(): curr_state = States.JUMP
	if velocity.y > 0: curr_state = States.FALL
	
	
	match curr_state:
		States.JUMP:
			velocity.y = Game.JUMP_VELOCITY
			anim.play("Jump")
		States.FALL:
			anim.play("Fall")
		States.RUN:
			if direction == -1: anime.flip_h = true
			elif direction == 1: anime.flip_h = false
			velocity.x = direction * SPEED
			anim.play("Run")
		States.IDLE:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			anim.play("Idle")
	
	move_and_slide()	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	

	
	
	if Game.playerHP <= 0:
		queue_free()
		Game.playerHP = 1
		Utils.SaveGame()
		get_tree().change_scene_to_file("res://main.tscn")
