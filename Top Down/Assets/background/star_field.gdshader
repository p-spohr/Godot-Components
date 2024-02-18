shader_type canvas_item;

uniform vec3 background_color : source_color;
uniform vec3 multiply_color : source_color;
uniform sampler2D space_pattern_sampler : repeat_enable, filter_linear_mipmap;
uniform sampler2D star_tile_sampler : filter_linear_mipmap;
uniform sampler2D stars_color_gradient;

uniform float seed = 0.0;
uniform float chance = 0.95;
uniform float base_scale = 40.0;
uniform float star_count = 40.0;
uniform vec2 view_offset = vec2(0.0);

// Credits: Random and Rotate functions from godotshaders.com
// https://godotshaders.com/snippet/rotate/
float random (vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

vec2 rotate(vec2 uv, vec2 pivot, float angle) {
	mat2 rotation = mat2(
		vec2(sin(angle), -cos(angle)),
		vec2(cos(angle), sin(angle))
	);
	
	uv -= pivot;
	uv = uv * rotation;
	uv += pivot;
	return uv;
}

float map(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

vec4 draw_stars(vec2 coord, vec2 offset, float base_seed) {
	vec2 frag_coord_offset = coord + offset;
	
	vec2 position = fract(1.0 / (star_count) * frag_coord_offset);
	float cell_id = random(round(1.0 / star_count * frag_coord_offset + 0.5) + base_seed);
	
	float stars_mask = 0.0;
	vec3 stars_color = vec3(0.0);
	
	if(cell_id > chance) {
		float clamped_id = (map(cell_id, chance, 1.0, 0.0, 1.0));
		stars_color = texture(stars_color_gradient, vec2(clamped_id, 0.0)).rgb;
		
		position.x += sin(clamped_id * 10.0) * 0.1;
		position.y += cos(clamped_id * 15.0) * 0.1;
		
		float scale = base_scale + (sin(clamped_id * 40.0 + TIME * 2.0) * 0.15);
		vec2 scaled_pos = (position - 0.5) * scale + 0.5;
		float star_id = floor(clamped_id * 3.0);
		vec2 star_uv = (scaled_pos + vec2(star_id, 0.0)) / vec2(3.0, 1.0);
		stars_mask = texture(star_tile_sampler, star_uv).x;
	}
	return vec4(stars_color, stars_mask);
}

void fragment() {
	vec2 base_uv = rotate(
		(UV * vec2(1.0, 0.95)) * 1.95 + vec2(0.0, sin(UV.x * PI * 2.0) * 0.15), // changes bend of space_pattern
		vec2(1.0), // increasing moves space_pattern up
		1.79 // increasing rotates space_pattern clockwise
	);
	
	base_uv *= 0.85; // increase to make space_pattern smaller (texture is set to repeat)
	base_uv.x += TIME * 0.015; // increase multiplier to increase speed of space_pattern

	float space_pattern = texture(space_pattern_sampler, base_uv).x;
	
	float distance_to_center = 1.0 - distance(UV, vec2(0.5));
	distance_to_center = 
	smoothstep(
		0.25, // increasing removes outside of space_pattern
		1.1,  // increasing adds more opacity to space_pattern
		distance_to_center);
									
	float pattern = ((1.0 - space_pattern) * distance_to_center) * 0.4 + 0.6;
	
	vec3 background = background_color * mix(multiply_color, vec3(1.0), pattern);
	
	vec4 stars_1 = draw_stars(
		FRAGCOORD.xy,
		view_offset * 0.45, // increase multiplier to make the first layer of stars appear closer
		seed + 50.0);
	vec4 stars_2 = draw_stars(
		FRAGCOORD.xy, 
		view_offset * 0.25, // decrease multiplier to make the second layer of stars appear farther
		seed + 100.0);
	vec4 stars_3 = draw_stars(
		FRAGCOORD.xy,
		view_offset * 0.10, // increase multiplier to make the first layer of stars appear closer
		seed + 200.0);
	vec4 stars_4 = draw_stars(
		FRAGCOORD.xy, 
		view_offset * 0.05, // decrease multiplier to make the second layer of stars appear farther
		seed + 300.0);
		
	vec4 stars_forward = mix(stars_2, stars_1, stars_1.a);
	
	vec4 stars_backward = mix(stars_3, stars_4, stars_4.a);
	
	vec4 stars = mix(stars_backward, stars_forward, stars_1.a);
	
	COLOR.rgb = mix(background, stars.rgb, stars.a);
}