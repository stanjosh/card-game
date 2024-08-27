
extends MarginContainer
class_name Deck

@onready var card_back_texture = $CardBack/CardBackTexture

@onready var card_number = $CardBack/CardNumber/CardNumberLabel

func _ready():
	Cards.cards_updated.connect(update_deck)
	card_number.text = "%s" % 0

func update_deck(_hand, deck: Array[CardInfo], discard_pile: Array[CardInfo]):
	card_number.text = "%s" % deck.size()
	card_back_texture.visible = false if Cards.deck.size() == 0 else true
