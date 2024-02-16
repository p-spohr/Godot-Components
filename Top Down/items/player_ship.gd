extends CharacterBody2D


@export var speed : float = 500.0

var player_direction : Vector2
var slow_speed : float = 2
var steering : Vector2
var slowed : bool = false
var braked : bool = false
var steering_type : String
var movement_type : String

func _ready() -> void:
	
	steering_type = 'wasd'
	movement_type = 'velocity'


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
	
	
	#if slowed == true:
		#position += player_direction * (speed / slow_speed) * delta
		#
	#else:
		#pass
		#

	if movement_type == 'velocity':
		
		velocity += player_direction * speed * delta
		
		velocity.x = clamp(velocity.x, -500, 500)
		velocity.y = clamp(velocity.y, -500, 500)
		
	if movement_type == 'position':
		
		# does not work with pull and push astroids
		# does not work with wasd based movement
		velocity = Vector2.ZERO
	
		position += player_direction * speed * delta
	
	
	if steering_type == 'wasd':
		wasd_steering()
		
	if steering_type == 'mouse':
		mouse_steering()
	
		
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
	# print(player_direction)
	# print(position.angle())
	
	move_and_slide()


func _on_quit_game_pressed() -> void:
	
	get_tree().quit()


func _on_change_level_pressed() -> void:
	
	get_tree().change_scene_to_file("res://menus/SelectLevel.tscn")


func mouse_steering() -> void:
	
	look_at(get_global_mouse_position())
	
func wasd_steering() -> void:
	
	if movement_type == 'velocity':
		rotation = velocity.angle()
	else:
		rotation = player_direction.angle()

func _on_steering_option_item_selected(index: int) -> void:
	
	match index:
		0:
			steering_type = 'wasd'
			print(steering_type)
		1:
			steering_type = 'mouse'
			print(steering_type)


func _on_movement_option_item_selected(index: int) -> void:
	
	match index:
		0:
			movement_type = 'velocity'
			print(movement_type)
		1:
			movement_type = 'position'
			print(movement_type)
