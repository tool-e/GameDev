extends CharacterBody2D

var SPEED = 300
var PRECONDITIONS = {
	'player_highground': false,
	'platform_overhead': false,
}



@onready var ray_cast = $RayCast2D
var sweep_speed: float = 2.0
var sweep_time: float = 0.0

								#ACTION STATES
func CHASE() -> void:
	get_node("AnimatedSprite2D").play("Jump")
	var player = get_node("../../PLAYER/Player")
	var direction = (player.position - self.position).normalized()
	var speed = 300
	
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = true
	else:
		get_node("AnimatedSprite2D").flip_h = false
		
	velocity.x = direction.x * speed 
		
	move_and_slide()
	
								#PROCESS
func _ready() -> void:
	get_node("AnimatedSprite2D").play("Idle")
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	CHASE()
	# Sweep the raycast back and forth using a sine wave
	sweep_time += delta * sweep_speed
	
	# Rotate the RayCast around its local origin
	ray_cast.rotation = sin(sweep_time) * deg_to_rad(45) # Sweeps a 90-degree arc
	
	if ray_cast.is_colliding():
		var hit_object = ray_cast.get_collider()
		var hit_point = ray_cast.get_collision_point()
		#print("Swept and hit: ", hit_object.name)
		#print(hit_point)
		
		if hit_object.name == "Player":
			velocity.y = Game.JUMP_VELOCITY


func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Game.playerHP -= 3
		Utils.SaveGame()
		
