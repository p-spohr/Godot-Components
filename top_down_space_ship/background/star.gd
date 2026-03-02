extends Sprite2D

@onready var player_ship: CharacterBody2D
@onready var player_camera: Camera2D

var shader_instance : ShaderMaterial
var rng = RandomNumberGenerator.new()
var randomize_clockwise: int

func _ready() -> void:
	
	await get_tree().root.ready
	
	# can't change instances for canvas_items, so fucked up!
	shader_instance = material.duplicate() # create instance of material
	randomize_clockwise = rng.randi_range(0, 10)
	
	# I DID IT! HELL YEAH! However, the change only applies once when _ready() is called
	# which means it stops when the next level is selected
	if randomize_clockwise < 5:
		#shader_instance.clockwise = false
		shader_instance.set_shader_parameter('clockwise', false) # change parameter on instance
		material = shader_instance # apply the new shader instance to material
	else: 
		#shader_instance.clockwise = true
		shader_instance.set_shader_parameter('clockwise', true)
		material = shader_instance
	
func _process(_delta: float) -> void:
	
	
	if get_tree().current_scene.has_node("PlayerShip"):
		
		player_ship = get_tree().current_scene.get_node("PlayerShip")
		player_camera = player_ship.get_node("Camera2D")
	
		material.set_shader_parameter("view_offset", player_camera.global_position)
	
		
	# print(_camera)
