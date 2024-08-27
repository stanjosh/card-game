@tool
extends TextureRect

@export var color1 : Color :
	set(value):
		color1 = value
		change_gradient()

@export var color2 : Color :
	set(value):
		color2 = value
		change_gradient()

@export var color3 : Color :
	set(value):
		color3 = value
		change_gradient()

@export var color4 : Color :
	set(value):
		color4 = value
		change_gradient()

@export_range(0, 8) var jitter : float  = 1 :
	set(value):
		jitter = value
		texture.noise.set("cellular_jitter", value)

@export_range(0, 1) var gradient_speed : float = .01 :
	set(value):
		gradient_speed = value
		material.set("shader_parameter/speed_scale", gradient_speed)
		
@export_range(0, 1) var frequency : float = .5 :
	set(value):
		frequency = value 
		texture.noise.set("frequency", frequency / 10)

var frequencies : Array[float]= [0.012, 0.06, 0.1, 0.25]



func change_gradient():
	var new_gradient := Gradient.new()
	new_gradient.set_color(0, color1)
	new_gradient.set_color(1, color1)
	new_gradient.add_point(0.25, color2)
	new_gradient.add_point(0.5, color3)
	new_gradient.add_point(0.75, color4)
	var new_gradient_texture = GradientTexture1D.new()
	new_gradient_texture.gradient = new_gradient
	material.set("shader_parameter/gradient", new_gradient_texture)

func change_gradient_speed(speed : float) -> void:
	material.set("shader_parameter/speed_scale", speed)
