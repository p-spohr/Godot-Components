shader_type canvas_item;

uniform float distortion_strength : hint_range(-1, 1);
uniform vec4 color_tone : source_color;
uniform sampler2D screen_texture : hint_screen_texture;
uniform float uv_scale_1 : hint_range(0, 10);
uniform vec2 uv_scroll_1 = vec2(0.05, 0.05);
uniform float uv_scale_2 : hint_range(0, 10);
uniform vec2 uv_scroll_2 = vec2(0.05, 0.05);


uniform sampler2D noise : repeat_enable;

void vertex() {
	
}

void fragment() {
	
	vec4 layer_1 = texture(noise, UV * uv_scale_1 + uv_scroll_1 * TIME);
	vec4 layer_2 = texture(noise, UV * uv_scale_2 + uv_scroll_2 * TIME);
	
	// layer_1.a = 0.1;
	
	layer_1.r = 2.2;
	layer_2.b = 3.5;
	
	// layer_1.a = max(0.92, abs(sin(TIME)));
	
	COLOR = color_tone * layer_1 * layer_2;


}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
