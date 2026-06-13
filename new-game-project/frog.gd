extends CharacterBody2D


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


var Player
var SPEED = 50
var chase

func _ready() -> void:
	get_node("AnimatedSprite2D").play("Idle")
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death": get_node("AnimatedSprite2D").play("Jump")
		Player = get_node("../../PLAYER/Player")
		var direction = (Player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
			
		velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "Death": 
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
		
	move_and_slide()


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true

func _on_player_detection_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int,  _local_shape_index: int) -> void:
	if body.name == "Player":
		chase = false

func death():	
	chase = false
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
		
func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Game.GOLD += 1
		death()
		Utils.SaveGame()

func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Game.playerHP -= 3
		Utils.SaveGame()
		death()
