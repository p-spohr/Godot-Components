shader_type canvas_item;

uniform bool clockwise = true;
uniform vec2 increase_size = vec2(1.0, 1.0);
uniform vec2 circle_size = vec2(10.0, 10.0);

uniform vec2 view_offset = vec2(0.0);

uniform int SEED = 1;

float random_generator(int seed, vec2 base_vert, float pi) {
	
	float float_seed = float(seed);
	
	float start_random = abs(float(float_seed) * sin(float_seed/pi));
	float vert_random_x = (pi * start_random) / base_vert.x;
	float vert_random_y = (2.0 * pi * start_random) / base_vert.y;
	float vert_random = vert_random_x + vert_random_y;
	//vec2 time_vect_random = vec2(time_random, time_random);
	//float mod_time_random = mod(uv_random, time_vect_random).x * mod(uv_random, time_vect_random).y;
	
	return 10.0 * float_seed * start_random * vert_random;
	
}

 float random (vec2 vert) {
	vert.x = PI / 2.0;
	vert.y = PI / 3.0;
	return fract( dot( vert, vec2(12.9898, 78.233) ) * 43758.5453123 );
	}
 
vec2 move_right() {
	return vec2(10.0, 0.0);
}

void vertex() {
	
	// VERTEX += move_right();
	
	// counter clockwise circle
	// VERTEX = (vec2(10.0, 0.0) * sin(TIME)) + (vec2(0.0, 10.0) * cos(TIME));
	
	// clockwise circle
	// VERTEX = (vec2(10.0, 0.0) * cos(TIME)) + (vec2(0.0, 10.0) * sin(TIME));
	
	// float random_size = random_generator(SEED, VERTEX, PI);
	
	// float random_size = random(VERTEX);
	
	// VERTEX *= random_size * 10.0;
	
	// VERTEX *= increase_size; // scale the sprite size up and down
	
	if (clockwise == true) 
	{
		VERTEX.x += (circle_size.x * cos(TIME));
		VERTEX.y += (circle_size.y * sin(TIME));
		
	} else {
		VERTEX.x += (circle_size.x * sin(TIME));
		VERTEX.y += (circle_size.y * cos(TIME));
	}
	
	// this makes the stars look like they are moving oppostie of the camera
	// but the star pattern does not repeat itself and the screen becomes blank
	VERTEX += -view_offset * 0.1;
	
	// VERTEX.y += 10.0; move the sprite down
		//
	//if (VERTEX.x < 0.0) {
		//
		//VERTEX.x -= 0.0; // stretch the sprite left
	//}
	
}


void fragment() {
	

		
	vec4 input_color = texture(TEXTURE, UV);
	
	vec4 glow_color = texture(TEXTURE, UV);

	vec4 glow_layer = vec4(1.0, 1.0, 1.0, 0.1);
	
	// COLOR = vec4(1.0, 0.0, 0.0, input_color.a); // make the image red based on sprite alpha
	
	// make half the sprite blue
	if (UV.x < 0.5) {
		
		COLOR = vec4(0.0, 0.0, 1.0, input_color.a); // + glow_layer.a;
		
	} else {
		COLOR = vec4(1.0, 0.0, 1.0, input_color.a); // + glow_layer.a;
	}
	
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
