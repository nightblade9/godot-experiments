shader_type canvas_item;

uniform float time : hint_range(-7, 7) = 0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float adjusted_sine = (sin(time) + 1.0) / 2.0; // map -1..1 to 0..1
	COLOR = mix(color, vec4(1, 1, 1, color.a), adjusted_sine); 
}