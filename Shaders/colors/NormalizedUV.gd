extends ColorRect

var current_shader : ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	current_shader = material
	current_shader.set_shader_parameter("rect_size", Vector2(10.0, 10.0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
