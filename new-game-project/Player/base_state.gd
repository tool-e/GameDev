class_name BaseState extends Player


#@onready var anim: AnimationPlayer = $"../AnimationPlayer"
#@onready var anime: AnimatedSprite2D = $"../AnimatedSprite2D"
#
#
##Handle direction and which way player looks	
#var direction := Input.get_axis("ui_left", "ui_right")
#func MOVE() -> void:
	#if direction == -1: anime.flip_h = true
	#elif direction == 1: anime.flip_h = false
	#velocity.x = direction * SPEED
	 #
#
##States the player can be in at any given time
#func RUN() -> void:
	#if direction == -1: anime.flip_h = true
	#elif direction == 1: anime.flip_h = false
	#velocity.x = direction * SPEED
	#anim.play("Run")
#
#func IDLE() -> void:
	#velocity.x = move_toward(velocity.x, 0, SPEED)
	#anim.play("Idle")
#
#func JUMP() -> void:
	#MOVE()
	#velocity.y = Game.JUMP_VELOCITY
	#anim.play("Jump")
	#
#func FALL() -> void:
	#MOVE()
	#anim.play("Fall")
