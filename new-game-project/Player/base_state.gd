class_name BaseState extends Player


@onready var anim: AnimationPlayer = $"../AnimationPlayer"
@onready var anime: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var Player: Player = $".."




func MOVE() -> void:
	direction = Input.get_axis("ui_left", "ui_right")
	anime.flip_h = true if direction == -1 else false #flip character into the direction he's moving
	Player.velocity.x = direction * SPEED
	 

#States the player can be in at any given time
func RUN() -> void:
	if direction and Player.is_on_floor(): 
		MOVE()
		anim.play("Run")
		curr_state = States.RUN 

func IDLE() -> void:
	if !direction and Player.is_on_floor(): 
		Player.velocity.x = move_toward(Player.velocity.x, 0, SPEED)
		anim.play("Idle")
		curr_state = States.IDLE
#
func JUMP() -> void:
	MOVE()
	if Input.is_action_just_pressed("ui_accept") and Player.is_on_floor(): 
		Player.velocity.y = Game.JUMP_VELOCITY
		anim.play("Jump")
		curr_state = States.JUMP
		print("test")
	
func FALL(delta) -> void:
	#Gravity
	if !Player.is_on_floor(): Player.velocity.y += Game.GRAVITY * delta
	#Falling
	if Player.velocity.y > 0:
		anim.play("Fall")
		curr_state = States.FALL
