extends Node2D

var player_ship : CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print(get_tree().current_scene)
	
	player_ship = get_node("PlayerShip")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass
	
	
	# queue_redraw()
	

#func _draw() -> void:
	#
	#if len(player_ship.mouse_position_packed_array) > 2:
		#draw_polyline(player_ship.mouse_position_packed_array, Color(1.0, 0.0, 0.0))
	#
	#



func _on_button_pressed() -> void:
	get_tree().quit()
