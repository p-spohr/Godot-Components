shader_type canvas_item;

uniform vec4 select_color : source_color;
uniform vec2 mouse_position;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	// COLOR = vec4(1.0, 0.0, 1.0, 1.0);
	
	COLOR = select_color;
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
