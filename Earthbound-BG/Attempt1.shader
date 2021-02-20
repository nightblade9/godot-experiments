shader_type canvas_item;

uniform float time : hint_range(0, 10) = 0.0;

void fragment() {
	vec2 coordinates = vec2(UV.x, 1.0 * sin(1.0 * UV.y  + time));
	coordinates.y = (coordinates.y + 1.0) / 2.0;
	vec4 tex = texture(TEXTURE, coordinates);
	COLOR = tex;
}