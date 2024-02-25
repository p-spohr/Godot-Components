extends ColorRect

var shader_material : ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	shader_material = material
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	shader_material.set_shader_parameter("rect_size", size)


func _on_h_slider_x_value_changed(value: float) -> void:
	size.x = value


func _on_h_slidery_value_changed(value: float) -> void:
	size.y = value
