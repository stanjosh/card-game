@tool
extends Node

signal cards_updated(hand: Array[CardInfo], deck: Array[CardInfo], discard_pile: Array[CardInfo])

@export var hand : Array[CardInfo] = [] :
	set(value):
		hand = value
		if Settings.DEBUG:
			prints("Hand:", hand.size(), "Cards:", hand.map(func(i): return i.title))	
	get:
		if Settings.DEBUG:
			prints("Hand:", hand.size(), "Cards:", hand.map(func(i): return i.title))
		return hand
		
@export var deck : Array[CardInfo] = [] :
	get:
		if Settings.DEBUG and deck.size() > 0:
			prints("Deck:", deck.size(), "Top:", deck[-1].title)
		return deck
		
@export var temp_cards : Array[CardInfo] = [] :
	set(value):
		temp_cards = value
		cards_updated.emit(hand, deck, discard_pile)
		
@export var discard_pile : Array[CardInfo] = [] :
	set(value):
		discard_pile = value
		if Settings.DEBUG:
			prints("Discard:", discard_pile.size())
			
@export var max_hand_size : int = 7

var card_library : Array[CardInfo]


func get_random_deck(size : int = max_hand_size * 2 + randi()%20) -> Array[CardInfo]:
	var new_deck : Array[CardInfo] = []
	while new_deck.size() < size:
		var new_card : CardInfo = card_library.pick_random()
		if randf() > new_card.rarity:
			new_deck.push_front(new_card)
	deck = new_deck
	discard_pile = []
	hand = []
	cards_updated.emit(hand, deck, discard_pile)
	return new_deck

#func add_new_card_to_hand(new_card : CardInfo) :
	#hand.push_front(new_card)
	#temp_cards.push_back(new_card)
	#hand_updated.emit()

func add_card_to_deck(new_card : CardInfo) :
	deck.push_back(new_card)
	cards_updated.emit(hand, deck, discard_pile)

func draw_card() -> void:
	return draw_cards(1)

func draw_cards(num : int = max_hand_size) -> void :
	if num > max_hand_size \
	or num + hand.size() > max_hand_size or \
	num > deck.size():
		prints("too many cards!")
		num = mini(max_hand_size - hand.size(), deck.size())
	prints("drawing", num, "cards")
	for i in range(0, num):
		hand.push_front(deck.pop_front())
	cards_updated.emit(hand, deck, discard_pile)

func discard_all():
	prints("discard all")
	discard_pile += hand
	hand = []
	cards_updated.emit(hand, deck, discard_pile)

func discard_card(card_info: CardInfo) -> void:
	discard_cards([hand.find(card_info)])

func discard_cards(cards : Array[int]) -> void:
	prints("discard array of size", cards.size())
	for index in cards:
		var card = hand.pop_at(index)
		discard_pile.push_back(card)
	cards_updated.emit(hand, deck, discard_pile)
	
func shuffle_deck(include_discard : bool = false, include_hand : bool = false) -> Array[CardInfo]:
	if include_discard:
		deck += discard_pile
		discard_pile = []
	if include_hand:
		deck += hand
		hand = []
	deck.shuffle()
	cards_updated.emit(hand, deck, discard_pile)
	return deck

func clear_temp_cards():
	temp_cards = []

func show_deck_cards(number : int = deck.size(), ordered : bool = false) -> Array[CardInfo]:
	var displayed_deck : Array[CardInfo] = deck.slice(0, number)
	if !ordered:
		displayed_deck.shuffle()
	return displayed_deck

func create_card(card_info : CardInfo) -> Card2D:
	var new_card : Card2D = Settings.CARD.instantiate()
	new_card.card_info = card_info
	return new_card


func _ready():
	if Settings.DEBUG:
		seed(123)
	load_resources("res://cards/card_infos/")
	print(card_library.map(func(card_info): return card_info.title))

func load_resources(path: String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			card_library.push_back(load(path + file_name))
			file_name = dir.get_next()
