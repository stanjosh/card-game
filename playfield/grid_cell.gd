extends PanelContainer
class_name PlayFieldGridCell

signal cell_changed(cell: PlayFieldGridCell)

var card_info : CardInfo
var tile_position : Vector2i

func _ready() -> void:
	custom_minimum_size = Vector2(Settings.CARD_TILE_SIZE) * Settings.TILE_SIZE
	update_minimum_size()
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is Card2D:
		self_modulate = Color("GREEN", 0.9)
	else:
		self_modulate = Color("RED", 0.9)
	return data is Card2D
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	card_info = data.card_info
	cell_changed.emit(self)
	Cards.discard_card(data.card_info)

func _on_mouse_entered() -> void:
	self_modulate = Color("WHITE", 0.8)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.8, 0.1).from(0.0).set_trans(Tween.TRANS_SPRING)

func _on_mouse_exited() -> void:
	self_modulate = Color("WHITE", 0.8)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.2)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		GameCamera.target_position = global_position
