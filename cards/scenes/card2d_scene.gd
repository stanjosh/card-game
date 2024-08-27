@tool
extends AspectRatioContainer
class_name Card2D

signal hovered(card: Card2D)
signal clicked(card: Card2D)


@onready var card_face: TextureRect = $Container2/CardFace
@onready var rare_shine: TextureRect = $Container2/CardFace/RareShine
@onready var card_title: RichTextLabel = $Container2/Container/VBoxContainer/TitlePanel/TitleContainer/CardTitle
@onready var card_tile_map: TileMapLayer = $Container2/Container/VBoxContainer/TilePanel/TileContainer/CardTileMap
@onready var card_desc: RichTextLabel = $Container2/Container/VBoxContainer/PanelContainer/MarginContainer2/CardDesc
var dragging : bool = false

var is_hovered : bool = false :
	set(value):
		is_hovered = value
		if is_hovered == true:
			hovered.emit(self)
		else:
			hovered.emit(null)

const DEFAULT = preload("res://cards/card_infos/unknown.tres")
@export var card_info : CardInfo = DEFAULT :
	set(value):
		if value is CardInfo:
			card_info = value
			card_info.changed.connect(update)

func _ready() -> void:
	update()

func update():
	card_tile_map.clear()
	var card_pattern = card_tile_map.tile_set.get_pattern(card_info.pattern)
	card_tile_map.set_pattern(Vector2i(0,0), card_pattern)
	card_title.text = "%s" % card_info.title
	card_desc.text = "%s" % card_info.description
	rare_shine.visible = true if card_info.rarity > .8 else false
	card_face.self_modulate = Color.WHITE if card_info.rarity > .4 else Color.DIM_GRAY

func _get_drag_data(_pos):
	
	var preview_card : Card2D = Cards.create_card(card_info)
	visible = false
	var preview = Control.new()
	preview.add_child(preview_card)
	set_drag_preview(preview)
	return self

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	print("ok")
	return data is Card2D
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.reparent(get_parent())

func _notification(notification_type):
	match notification_type:
		NOTIFICATION_DRAG_END:
			visible = true
			print("END")

func _gui_input(event: InputEvent) -> void:
	#if dragging:
		#global_position = get_global_mouse_position() + Vector2(10, 10)
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#clicked.emit(self)
	is_hovered = true
	
	
