@tool
extends Resource
class_name CardInfo



enum Pattern {
	LAKE,
	VILLAGE,
	TREES,
	GRASSLAND,
	HIGHWAY,
	BUILDING,
	GRAVEYARD,
	UNKNOWN
}

@export var title : String :
	set(value):
		title = value
		changed.emit()

@export var description : String :
	set(value):
		description = value
		changed.emit()
		
@export_range(0, .9) var rarity : float :
	set(value):
		rarity = value
		changed.emit()
		
@export var pattern : Pattern :
	set(value):
		pattern = value
		changed.emit()

@export_file("*card_effect.gd") var card_effect_script : String :
	set(value):
		card_effect_script = value
		if card_effect_script != null:
			card_effects = load(card_effect_script)

var card_effects : CardEffect

var in_hand : Callable :
	get:
		return card_effects.in_hand
	
var on_play : Callable :
	get:
		return card_effects.on_play
	
var on_discard : Callable :
	get:
		return card_effects.on_discard

var in_playfield : Callable :
	get:
		return card_effects.in_playfield
