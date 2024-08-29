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
