@tool
extends HBoxContainer
class_name Hand

@export_category("Positioning")
@export var position_curve : Curve = Curve.new()
@export var hand_width : int = 32 :
	set(value):
		hand_width = value
		arrange_cards()
@export var hand_height : int = 10 :
	set(value):
		hand_height = value
		arrange_cards()
@export var card_angle_limit : int = 30 :
	set(value):
		card_angle_limit = value
		arrange_cards()
@export_category("Editor")
@export var arrange_cards_in_editor : bool :
	set(_value):
		arrange_cards()
		arrange_cards_in_editor = false
		
@export var draw_card_in_editor : bool :
	set(_value):
		Cards.draw_cards(1)
		draw_card_in_editor = false
		
@export var new_deck_in_editor : bool :
	set(_value):
		Cards.get_random_deck()
		new_deck_in_editor = false

var cards : Array[Card2D] = []
var current_hovered_card : Card2D
var hovered_z_index : int

func _ready():
	#clear_hand()
	Cards.cards_updated.connect(update)
	position_curve.changed.connect(arrange_cards)

func update(hand : Array[CardInfo], _deck, _discard_pile) -> void:
	for card in get_children():
		card.queue_free()
	if hand.size() > 0:
		for card_info in hand:
			var new_card = Cards.create_card(card_info)
			new_card.clicked.connect(_on_card_clicked)
			new_card.hovered.connect(_on_card_hover)
			add_child(new_card)
	arrange_cards()

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	print("ok")
	return data is Card2D
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.reparent(self)
	arrange_cards()

func arrange_cards() -> void:
	prints("showing hand", get_child_count())
	var position_ratio : float = 0.5

func _process(delta) -> void:
	for card in get_children():
		if card == current_hovered_card:
			card.rotation = lerpf(card.rotation, 0, 10 * delta)
		else:
			if get_children().size() > 1:
				var offset =  deg_to_rad(position_curve.sample(float(card.get_index()) / float(get_child_count() - 1)) * card_angle_limit)
				card.rotation = lerpf(card.rotation, offset, 2 * delta)
			
func discard(card : Card2D):
	Cards.discard_card(card.card_info)

func _on_card_clicked(card: Card2D = null) -> void:
	if card == current_hovered_card:
		discard(current_hovered_card)
	

	
func _on_card_hover(card : Card2D = null) -> void:
	current_hovered_card = card



func _on_child_order_changed() -> void:
	arrange_cards()
