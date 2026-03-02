extends ColorRect

@onready var player_ship: CharacterBody2D
@onready var player_camera: Camera2D


func _ready() -> void:
	
	await get_tree().root.ready



func _process(_delta: float) -> void:
	
	
	if get_tree().current_scene.has_node("PlayerShip"):
		
		player_ship = get_tree().current_scene.get_node("PlayerShip")
		player_camera = player_ship.get_node("Camera2D")
	
		material.set_shader_parameter("view_offset", player_camera.global_position)
	
		
	# print(_camera)
