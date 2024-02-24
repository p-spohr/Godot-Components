shader_type canvas_item;

float plot_decrease(vec2 st) {
	
	return smoothstep(0.09, 0.0, abs(st.x - st.y)); // * sin(TIME); adds a cool firing effect
	
}

float plot_increase(vec2 st) {
	
	// kind of rotated it
	st.x = cos(st.x * (PI / 2.0));
	st.y = sin(st.y * (PI / 2.0));
	
	//st.x = sin(st.x) + PI/2.0;
	//st.y = cos(st.y) + PI/2.0;
	
	return smoothstep(0.09, 0.0, abs(st.y - st.x)); // * sin(TIME); adds a cool firing effect
	
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec2 st = UV;
	
	//st.x = 1.0 / st.x;
	//st.y = 1.0 / st.y;
	
	//st.y = 0.5;
	
	//st.x *= sin(TIME);
	// st.y *= cos(TIME);
	
	float y = st.x; // move gradient
	
	vec3 color = vec3(y);
	
	// float pct = plot_decrease(st);
	
	float pct = plot_increase(st);
	
	// color = (1.0 - pct) * color + pct * vec3(0.0, 1.0, 0.0);
	
	// creates a cool laser that almost looks like a lightsaber
	color = vec3(0.0, 1.0, 0.0) * pct + pct / 1.1;
	
	// color = vec3(0.0, 1.0, 0.0) * pct;
	
	COLOR = vec4(color, 1.0);
	
	
}



//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
