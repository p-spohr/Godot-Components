extends CharacterBody2D


@export var speed : float = 500.0

var player_direction : Vector2

var slow_speed : float = 2

var steering : Vector2

var slowed : bool = false

var braked : bool = false

func _process(delta: float) -> void:
	
	# already normalized
	player_direction = Input.get_vector("left", "right", "up", "down")
	
	# not normalized
	#player_direction.x = Input.get_axis("left", "right")
	#player_direction.y = Input.get_axis("up", "down")
	
	#if player_direction.length() > 1:
		#player_direction = player_direction.normalized()
	
	braked = Input.is_action_pressed("brake")
	
	# angle the ship based on mouse position
	# look_at(get_global_mouse_position())
	
func _physics_process(delta: float) -> void:
	
	
	if slowed == true:
		position += player_direction * (speed / slow_speed) * delta
		
	else:
		
		# position += player_direction * speed * delta

		velocity += player_direction * speed * delta
		
		velocity.x = clamp(velocity.x, -500, 500)
		velocity.y = clamp(velocity.y, -500, 500)
		
		# angle the ship based on direction of velocity
		rotation = velocity.angle()
		
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
	
	
	# stop the ship if colliding with astroid
	if is_on_wall():
		velocity += Vector2.ZERO - velocity * 0.1
	
	
	# print(velocity)
	print(player_direction)
	
	
	move_and_slide()


func _on_quit_game_pressed() -> void:
	
	get_tree().quit()


func _on_change_level_pressed() -> void:
	
	get_tree().change_scene_to_file("res://SelectLevel.tscn")
