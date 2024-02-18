extends Control

var end_timer : Timer
var start_timer : Timer

var end_text : String = "Till next time..."
var start_text : String = "Here we go..."

var ending_text : String
var end_button : Button
var starting_text : String
var start_button : Button

var end_time_to_wait : float
var start_time_to_wait : float

var test_arena_path : String

var start_game : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print(get_tree().current_scene)
	
	# get timer for when game is quit
	end_timer = get_node("EndTimer")
	start_timer = get_node("StartTimer")

	
	# get button for ending the game
	end_button = get_node("MarginContainer/VBoxContainer/EndGame")
	start_button = get_node("MarginContainer/VBoxContainer/StartButton")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# count down time after end timer starts
	end_time_to_wait = end_timer.time_left
	
	# if timer hasn't started then don't show changes
	if end_time_to_wait != 0:
		
		ending_text = show_ending(end_text, end_time_to_wait)
		end_button.text = ending_text
		get_node("MarginContainer/VBoxContainer/StartButton").disabled = true
		get_node("MarginContainer/VBoxContainer/SelectLevel").disabled = true
		# get_node("MarginContainer/VBoxContainer/EndGame").disabled = true

		
	start_time_to_wait = start_timer.time_left
	
	if start_time_to_wait != 0:
		
		starting_text = begin_scene(start_text, start_time_to_wait)
		start_button.text = starting_text
		# get_node("MarginContainer/VBoxContainer/StartButton").disabled = true
		get_node("MarginContainer/VBoxContainer/EndGame").disabled = true
		get_node("MarginContainer/VBoxContainer/SelectLevel").disabled = true

	
	
func _on_end_game_pressed() -> void:
	
	if end_timer.is_stopped():
		end_timer.start()

	
func _on_end_timer_timeout() -> void:
	
	end_game()

	
func show_ending(show_text : String, wait_time) -> String:
	
	wait_time = str(round(wait_time))
	
	return show_text + wait_time
	
	
func end_game() -> void:
	
	get_tree().quit()


func _on_start_button_pressed() -> void:
	
	if start_timer.is_stopped():
		start_timer.start()
	
	
func begin_scene(show_text : String, wait_time) -> String:
	
	wait_time = str(round(wait_time))
	
	return show_text + wait_time
	
func start_primary_scene(scene_path : String) -> void:
	
	get_tree().change_scene_to_file(scene_path)


func _on_start_timer_timeout() -> void:
	
	start_primary_scene(test_arena_path)


func _on_select_level_pressed() -> void:
	
	get_tree().change_scene_to_file("res://menus/SelectLevel.tscn")


