class_name Frog extends CharacterBody2D

const FROG_SPEED = 200.0
var DIRECTION


@onready var anime: AnimationPlayer = $AnimationPlayer
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var shapecast: ShapeCast2D = $ShapeCast2D
@onready var player = get_node("../../PLAYER/Player")


func _ready() -> void:
	shapecast.set_collide_with_areas(true)
	shapecast.set_collide_with_bodies(false)
	shapecast.set_collision_mask(1)
	shapecast.set_enabled(true)
	shapecast.set_exclude_parent_body(false)
	shapecast.set_max_results(32)
	shapecast.set_target_position( Vector2(10, 200) )                
	
	
func shapecasting() -> void:
	if shapecast.is_colliding() == true:
		DIRECTION = (shapecast.get_collision_point(3) - self.position).normalized()
		

func RESET() -> void:
	#print(self.get_global_position())
	if (self.get_global_position().y - Game.LAST_COORDINATES.y) > 3000:
		self.velocity = Vector2.ZERO
		self.set_global_position(Game.LAST_COORDINATES)
		#get_tree().create_timer(10.0)

								#ACTION STATES
func CHASE() -> void:
	anime.play("Jump")
	
	DIRECTION = (player.position - self.position).normalized()
	if self.position < player.position and self.is_on_floor():
		self.velocity.y = Game.JUMP_VELOCITY
		shapecasting()
	
	if DIRECTION.x > 0:
		anim.flip_h = true
	else:
		anim.flip_h = false
		
	self.velocity.x = self.DIRECTION.x * FROG_SPEED 
		
func IDLE() -> void:
	if player.position < self.position and player.is_on_floor():
		self.velocity.x = move_toward(self.velocity.x, 0, FROG_SPEED)
		anime.play("Idle")	


	
								#PROCESS
	
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	CHASE()
	IDLE()
	RESET()
	
	move_and_slide()

func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Game.playerHP -= 3
		
		
