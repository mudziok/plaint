shader_type canvas_item;

uniform sampler2D noise;
uniform vec4 color_light : hint_color;
uniform vec4 color_dark : hint_color;

void fragment() {
	float n = texture(noise, (SCREEN_UV.xy + TIME * 0.01) * 5.0).r * 1.5;
	float b = texture(TEXTURE, UV.xy).r;
	float alpha = step(0.3, (-b + n) * 2.0);
	float lighter = step(1.0, (-b + n) * 2.0);
	vec4 color = color_dark * (1.0 - lighter) + color_light * lighter;
	COLOR = vec4(color.rgb, alpha);
}