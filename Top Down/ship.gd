extends CharacterBody2D


@export var speed : float = 500.0

var player_direction : Vector2

var slow_speed : float = 2

var steering : Vector2

var slowed : bool = false

var braked : bool = false

func _process(delta: float) -> void:
	
	player_direction = Input.get_vector("left", "right", "up", "down")
	
	braked = Input.is_action_pressed("brake")
	
	look_at(get_global_mouse_position())
	
func _physics_process(delta: float) -> void:
	
	
	if slowed == true:
		position += player_direction * (speed / slow_speed) * delta
		
	else:
		
		# position += player_direction * speed * delta

		velocity += player_direction * speed * delta
		
		velocity.x = clamp(velocity.x, -500, 500)
		velocity.y = clamp(velocity.y, -500, 500)
		
		# feels unresponsive
		# velocity = lerp(Vector2.ZERO, velocity, 0.98)
		
		# this works to make the ship return to zero smoothly but interferes with the astroid push and pull
		#if player_direction.length() == 0:
			#
			#velocity += Vector2.ZERO - velocity * 0.01
	#
	# print((player_direction - position).normalized())
	
	# print(braked)
	# this is a nice addition and makes sense when getting pushed or pulled 
	if braked:
		velocity += Vector2.ZERO - velocity * 0.03
	
	print(velocity)
	
	move_and_slide()
