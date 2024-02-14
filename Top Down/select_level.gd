extends Control

var list_of_levels : Array = [
	"res://test_map.tscn", 
	1, 
	2, 
	3, 
	4, 
	5, 
	6, 
	7, 
	8]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_astroid_pull_pressed() -> void:
	
	change_level(list_of_levels[0])


func change_level(scene_path : String) -> void:
	
	get_tree().change_scene_to_file(scene_path)
