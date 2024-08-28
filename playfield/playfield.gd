extends SubViewportContainer


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		pass

func _ready() -> void:
	%GameCamera.set_camera_limits(get_rect())
	
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:

	return data is Card2D
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	
	prints(at_position, data.card_info)
	pass
