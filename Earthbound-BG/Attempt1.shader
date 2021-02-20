shader_type canvas_item;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	float average = (tex.r + tex.g + tex.b) / 3.0;
	COLOR = vec4(average, average, average, tex.a);
}