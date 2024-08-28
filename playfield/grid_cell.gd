extends PanelContainer
class_name PlayFieldGridCell

signal cell_changed(cell: PlayFieldGridCell)
signal cell_focused(cell: PlayFieldGridCell)

var card_info : CardInfo
var tile_position : Vector2i

func _ready() -> void:
	custom_minimum_size = Vector2(Settings.CARD_TILE_SIZE) * Settings.TILE_SIZE
	update_minimum_size()



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
		cell_focused.emit(self)
