class_name BaseState extends Player


@onready var anim: AnimationPlayer = $"../AnimationPlayer"
@onready var anime: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var Player: Player = $".."

const PLAYER_SPEED = 300.0

func MOVE() -> void:
	direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		anime.flip_h = true
	elif direction == 1: anime.flip_h = false #flip character into the direction he's moving
	Player.velocity.x = direction * PLAYER_SPEED
	 

#States the player can be in at any given time
func RUN() -> void:
	if direction and Player.is_on_floor(): 
		MOVE()
		anim.play("Run")
		curr_state = States.RUN 

func IDLE() -> void:
	if !direction and Player.is_on_floor(): 
		Player.velocity.x = move_toward(Player.velocity.x, 0, PLAYER_SPEED)
		anim.play("Idle")
		curr_state = States.IDLE
#
func JUMP() -> void:
	MOVE()
	if Input.is_action_just_pressed("ui_accept") and Player.is_on_floor():
		Game.LAST_COORDINATES = Player.get_global_position()
		Player.velocity.y = Game.JUMP_VELOCITY
		anim.play("Jump")
		curr_state = States.JUMP
		#print(Game.LAST_COORDINATES) 
	
	
	
	
func FALL(delta) -> void:
	#Gravity
	if !Player.is_on_floor(): Player.velocity.y += Game.GRAVITY * delta
	#Falling
	if Player.velocity.y > 0:
		anim.play("Fall")
		curr_state = States.FALL
