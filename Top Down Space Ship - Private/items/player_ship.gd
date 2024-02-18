extends CharacterBody2D


@export var speed : float = 500.0

var player_direction : Vector2
var slow_speed : float = 2
var steering : Vector2
var slowed : bool = false
var braked : bool = false
var steering_type : String
var movement_type : String

var mouse_position_control : Control
var current_mouse_position : Vector2
var last_mouse_position : Vector2
var click_timer : Timer
var mouse_label : Label

var level_scene : SceneTree
var scene_theme : Theme = load("res://themes/space_theme.tres")

var mouse_position_packed_array : PackedVector2Array

func _ready() -> void:
	
	steering_type = 'wasd'
	movement_type = 'velocity'
	click_timer = get_node('ClickTimer')

	level_scene = get_tree()
	
	# OOHHHH IT FINALLY WORKED!
	# name = name of font in theme
	# theme_type = name of base type (Label) or custom type
	scene_theme.set_font_size('font_size', 'Label', 30)
	scene_theme.set_color('font_color', 'Label', Color(1.0, 1.0, 0.0))
	
	mouse_position_control = level_scene.current_scene.get_node("MousePosition")
	mouse_position_control.set_theme(scene_theme)

func _process(_delta: float) -> void:
	
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
	
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and click_timer.is_stopped():
		#
		#mouse_label = Label.new()
		#
		#current_mouse_position = round(get_global_mouse_position())
		#
		## print(level_scene.current_scene.get_node("MousePosition"))
		#
		#mouse_position_control.add_child(mouse_label)
		#
		#mouse_label.text = str(current_mouse_position)
		#mouse_label.position = current_mouse_position
		#
		#mouse_position_packed_array.append(current_mouse_position)
		#
		## queue_redraw()
#
		#click_timer.start()
#
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
	#
		#for child in mouse_position_control.get_children():
			#
			#child.queue_free()
			#
		#get_tree().reload_current_scene()
		#
		
#func _draw() -> void:
	#
	#if len(mouse_position_packed_array) > 2:
		#
		#draw_line_from_packed_array(mouse_position_packed_array)
	
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


func draw_line_from_packed_array(packed_array : PackedVector2Array) -> void:
	
	draw_polyline(packed_array, Color(1, 0, 0))
	
