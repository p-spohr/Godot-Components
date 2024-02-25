shader_type canvas_item;


void vertex() {
	
	
	
	
}

void fragment() {
	
	vec2 st = UV;
	
	
	// black
	// st.xy = vec2(0.0, 0.0);
	
	// red
	// st.xy = vec2(1.0, 0.0);
	
	// green
	// st.xy = vec2(0.0, 1.0);
	
	// yellow
	// st.xy = vec2(1.0, 1.0);
	
	// how to flip the uv?
	// I have no idea
	
	// completely split the green and red
	// st.y = mix(st.y, st.x, 100.0);
	// st.x = mix(st.y, st.x, 100.0);

	COLOR = vec4(st.x, st.y, 0.0, 1.0);
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
