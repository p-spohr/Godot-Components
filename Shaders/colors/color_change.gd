extends ColorRect

var color_picker_node : ColorPicker
var chosen_color : Color

var shader_material : ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	color_picker_node = get_node("ColorPicker")
	shader_material = material


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	chosen_color = color_picker_node.color
	shader_material.set_shader_parameter("select_color", chosen_color)
