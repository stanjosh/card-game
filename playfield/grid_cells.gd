extends GridContainer

signal card_played(card_played : CardInfo)

func _ready() -> void:
	draw_cells()
	

func draw_cells() -> void:
	for cell in get_children():
		cell.queue_free()
	var i_size = to_tilemap(size)
	columns = i_size.x 
	for x in i_size.x:
		for y in i_size.y:
			if y % Settings.TILE_SIZE * Settings.CARD_TILE_SIZE:
				var cell = Settings.GRID_CELL.instantiate()
				add_child(cell)


func to_tilemap(size:  Vector2) -> Vector2i:
	return Vector2i(
		size.x / (Settings.TILE_SIZE * Settings.CARD_TILE_SIZE.x),
		size.y / (Settings.TILE_SIZE * Settings.CARD_TILE_SIZE.y)
	)
