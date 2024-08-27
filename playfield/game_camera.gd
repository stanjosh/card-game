extends Camera2D


func set_camera_limits(rect: Rect2) -> void:
	limit_top = rect.position.y
	limit_bottom = rect.end.y
	limit_left = rect.position.x
	limit_right = rect.end.x
	position = rect.get_center()
	
var is_dragging : bool = false
var target_position : Vector2 = position
var target_zoom : Vector2 = zoom :
	set(value):
		target_zoom = clamp(value, Vector2(1, 1), Vector2(3, 3))
		target_position = get_global_mouse_position()


func _process(delta: float) -> void:
	position = lerp(position, target_position, 5 * delta)
	zoom = lerp(zoom, target_zoom, 5 * delta)

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				if event.is_released():
					target_zoom *= 1.1
			MOUSE_BUTTON_WHEEL_DOWN:
				if event.is_pressed():
					target_zoom *= 0.9
