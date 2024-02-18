extends ColorRect

@onready var player_ship : CharacterBody2D
@onready var player_camera : Camera2D


func _ready() -> void:
	
	await get_tree().root.ready
	
	
	#_camera = get_viewport().get_camera_2d()
	#set_process(_camera != null)


func _process(_delta: float) -> void:
	
	#if _camera:
		#material.set_shader_parameter("view_offset", _camera.global_position)
	
	# now the background shader moves accordingly with the ship, but it feels hacky
	if get_tree().current_scene.has_node("PlayerShip"):
		
		player_ship = get_tree().current_scene.get_node("PlayerShip")
		# print(player_ship)
		player_camera = player_ship.get_node("Camera2D")
		# print(player_camera)
		
	else:
		pass
		# print("No player!")
		
	if player_camera:
		material.set_shader_parameter("view_offset", player_camera.global_position)
