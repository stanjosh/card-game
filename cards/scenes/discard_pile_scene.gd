extends MarginContainer
class_name TargetZone


@onready var card_number_label: Label = $TextureRect/CardNumberLabel


func _ready() -> void:
	Cards.cards_updated.connect(_on_cards_updated)
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	print("ok")
	return data is Card2D
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	Cards.discard_card(data.card_info)

func _on_cards_updated(_deck, _hand, _discard):
	card_number_label.text = "%s" % Cards.discard_pile.size()
