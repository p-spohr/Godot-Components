shader_type canvas_item;

uniform vec2 tiling = vec2(1.0, 1.0);
uniform vec2 offset;

void vertex() {
	
	// UV = UV * tiling + offset * TIME;
	UV = UV * (TIME + 100.0);
	
}

void fragment() {
	
	
	// Called for every pixel the material is visible on.
	
	COLOR = vec4(0.12, 0.12, 0.12, 1.0);
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
