extends Sprite2D

@onready var player_ship: CharacterBody2D
@onready var player_camera: Camera2D

var rng = RandomNumberGenerator.new()
var randomize_clockwise: int

func _ready() -> void:
	
	await get_tree().root.ready
	
	# can't change instances for canvas_items, so fucked up!
	#randomize_clockwise = rng.randi_range(0, 10)
	#print(self, randomize_clockwise)
	#if randomize_clockwise < 5:
		#material.set_shader_parameter('clockwise', false)
		#material.set_shader_parameter('circle_size', Vector2(30.0, 30.0))
	#else: 
		#material.set_shader_parameter('clockwise', true)


func _process(_delta: float) -> void:
	
	
	if get_tree().current_scene.has_node("PlayerShip"):
		
		player_ship = get_tree().current_scene.get_node("PlayerShip")
		player_camera = player_ship.get_node("Camera2D")
	
		material.set_shader_parameter("view_offset", player_camera.global_position)
	
		
	# print(_camera)
