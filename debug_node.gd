extends Node2D

@onready var new_deck_button: Button = $VBoxContainer/Debug/NewDeckButton
@onready var draw_card_button: Button = $VBoxContainer/Debug/DrawCardButton
@onready var new_hand_button: Button = $VBoxContainer/Debug/NewHandButton
@onready var shuffle_all_button: Button = $VBoxContainer/Debug/ShuffleAllButton

var dragging : bool = false

func _ready() -> void:
	visible = true if Settings.DEBUG else false
	

func _on_new_hand_button_pressed():
	Cards.discard_all()
	Cards.draw_cards()


func _on_new_deck_button_pressed() -> void:
	Cards.get_random_deck(randi_range(20, 60))


func _on_shuffle_all_button_pressed() -> void:
	Cards.shuffle_deck(true, true)


func _on_draw_card_button_pressed() -> void:
	Cards.draw_card()


func _on_panel_container_gui_input(event: InputEvent) -> void:
	if dragging:
		position = get_global_mouse_position()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = true if event.is_pressed() else false
