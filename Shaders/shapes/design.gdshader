shader_type canvas_item;

uniform vec2 rect_size = vec2(300.0, 300.0);

const vec3 color_palette_array[4] =  
{
	vec3(0.500, 0.500, 0.500), vec3(0.500, 0.500, 0.500), vec3(1.000, 1.000, 1.000), vec3(0.263, 0.416, 0.557)
};

vec3 palette_array (float t, vec3 array[4]){
	return array[0] + array[1] * cos( 6.28318 * ( array[2] * t + array[3] ) );
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec2 base_uv = UV;

	vec3 final_color = vec3(0.0);
	float aspect_ratio = rect_size.x / rect_size.y;
	//// center the uv with a center of (0.0, 0.0)
	
	base_uv = (base_uv - 0.5) * 2.0 * aspect_ratio;
	
	for ( float i = 0.0; i < 4.0; i++ ) {
		

		vec2 center_uv = base_uv;
		vec3 colors = palette_array(length(center_uv) + TIME * 0.4 + ( i * 0.4 ), color_palette_array);	
		base_uv = fract(base_uv * 1.5) - 0.5;

		float len_uv = length(base_uv) * exp(-length(center_uv));
		// use palette to create colorful rings using fractals

		len_uv = sin( len_uv * 8.0 + TIME ) / 8.0;
		len_uv = abs(len_uv);
		len_uv = 0.03 / len_uv;
		//len_uv = smoothstep( 0.0, 0.1, len_uv ); fills the inner rings
		final_color += colors * len_uv * 0.3;
		
		
	}
	
	COLOR = vec4(final_color, 1.0);
	
	//base_uv = (2.0 * base_uv) - 1.0 * aspect_ratio;
	//// resize uv based on resolution or rectangle size
	//base_uv = base_uv * (rect_size.x / rect_size.y);
	
	// create a symetrical uv with a center of (0.0, 0.0)
	//base_uv = abs(base_uv - 0.5) * 2.0;

	
	// signed distance function
	// 0 at boundary of the shape, positive outside the shape, negative inside the shape
	//len_uv -= 0.5;
	//len_uv = abs(len_uv);
	
	// radial repetition with cirlces
	//len_uv = sin(len_uv * 8.0) / 8.0;
	//len_uv = abs(len_uv);
	
	//// radial repetition with cirlces shrinking
	//len_uv = sin(len_uv * 8.0 + TIME) / 8.0;
	//len_uv = abs(len_uv);
	//
	//// radial repetition with cirlces growing
	//len_uv = sin(len_uv * 8.0 - TIME) / 8.0;
	//len_uv = abs(len_uv);
	
	// sharpen the circle image
	//len_uv = step(0.1, len_uv);
	// smoothen the circle image
	//len_uv = smoothstep(0.0, 0.2, len_uv);
	
	// use bright colors using the inverse
	//len_uv = 0.1 / len_uv;
	
	//// red color for the rings
	//vec3 red = vec3(1.0, 0.0, 0.0);
	//red *= len_uv;
	//COLOR = vec4(red, 1.0);
	//
	// make red the mutliple while r and b equal to blue to create glow
	//float red_glow = 2.0;
	//vec3 red = vec3(red_glow, 1.0, 1.0);
	//red *= len_uv;
	//COLOR = vec4(red, 1.0);
	
	// use palette to create colorful rings
	//vec3 colors = palette_array(len_uv, color_palette_array);
	
	
	
	////// make red glow flicker
	//float red_glow = 2.0;
	//vec3 red = vec3(red_glow - abs(sin(TIME)), 1.0, 1.0);
	//red *= len_uv;
	//COLOR = vec4(red, 1.0);
	
	
	//// changes the 0.0 value of the uv to red
	//if (len_uv == 0.0) {
		//COLOR = vec4(1.0, 0.0, 0.0, 1.0);
	//}
	//// changes the 1.0 value of the uv to blue
	//if (len_uv == 1.0) {
		//COLOR = vec4(0.0, 0.0, 1.0, 1.0);
	//}
	
	//vec3 all_channel = vec3(base_uv, 0.0);
	
	//vec3 red_channel = vec3(base_uv.x, 0.0, 0.0);
	//
	//vec3 green_channel = vec3(0.0, base_uv.y, 0.0);
	//
	//COLOR = vec4(red_channel, 1.0);
	//COLOR = vec4(green_channel, 1.0);
	
	
	
	// f( x, y ) = ( r, g, b, a )
	// UV = ( x, y )
	//COLOR = vec4(all_channel, 1.0);
	
	// COLOR = vec4(len_uv, len_uv, len_uv, 1.0);
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
