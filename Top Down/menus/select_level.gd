extends Control

var grid_node : Control
var grid_children : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# returns direct children
	# array_node = get_node("PanelContainer/GridContainer").get_children()
	
	grid_node = get_node("PanelContainer/GridContainer")
	
	grid_children = grid_node.find_children("Astroid*")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func change_level(scene_path : String) -> void:
	
	get_tree().change_scene_to_file(scene_path)


func _on_quit_game_pressed() -> void:
	
	get_tree().quit()


func _on_astroid_pull_pressed() -> void:
	
	change_level("res://levels/Level_AstroidPull.tscn")


func _on_astroid_push_pressed() -> void:
	
	change_level("res://levels/Level_AstroidPush.tscn")


func _on_astroid_push_pull_pressed() -> void:
	
	change_level("res://levels/Level_AstroidPullPush.tscn")
