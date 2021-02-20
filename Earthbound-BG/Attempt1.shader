shader_type canvas_item;

uniform float time : hint_range(0, 10) = 0.0;

void fragment() {
	float sine = (1.0 + sin(time)) / 2.0;
	vec2 coordinates = vec2(UV.x, UV.y * sine);
	vec4 tex = texture(TEXTURE, coordinates);
	COLOR = tex;
}