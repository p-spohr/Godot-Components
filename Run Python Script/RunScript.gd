extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# get dir of path using Windows CMD
	var dir_output = []
	var exit_code_dir = OS.execute("CMD.exe", ["/C", "cd /Users/pat_h/OneDrive/public-repos/Godot-Components && dir"], dir_output)
	print(dir_output) # output is everything in string
	print(len(dir_output))
	
	var py_output = []
	var exit_code_py = OS.execute("CMD.exe", ["/C", "cd /Users/pat_h/OneDrive/public-repos/Godot-Components/Run Python Script && py PyTest.py"], py_output)
	print(py_output)
	print(len(py_output))
	
	var split_output = py_output[0].rsplit(":")
	
	print(split_output[1])
	var regex = RegEx.new()
	regex.compile("(\\d+)")
	var regex_output = regex.search_all(split_output[1])
	
	for reg_match in regex_output:
		print(reg_match)	
		var multiplier : int = 10
		print(int(reg_match.get_string()) * multiplier)

	#for ele in split_output[1]:
		#print(ele)

		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
