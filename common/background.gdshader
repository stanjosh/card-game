shader_type canvas_item;

uniform float speed_scale = 1;
uniform sampler2D gradient: repeat_enable, filter_nearest;


void fragment(){
	vec3 fog_color1 = texture(TEXTURE, vec2(UV.x / 2.0 + cos(TIME / 50.0), UV.y / 2.0 + TIME / 125.0)).rgb;
	vec3 fog_color2 = texture(TEXTURE, vec2(UV.x / 4.0 - TIME / 100.0, UV.y / 4.0 + sin(TIME / 50.0))).rgb;
	vec3 fog_color3 = texture(TEXTURE, vec2(UV.x / 6.0 + sin(TIME / 100.0), UV.y / 6.0 - TIME / 125.0)).rgb;
	vec3 fog_color = mix(fog_color1, mix(fog_color2, fog_color3, 0.5), 0.7);

	float x = fog_color.r - TIME * speed_scale;
	vec4 cycle = vec4(texture(gradient, vec2(x, 0)).rgb, 1);
	COLOR = vec4(cycle.rgb, 1);
}