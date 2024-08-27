extends ScrollContainer

@onready var playfield_tile_map: TileMapLayer = $PlayfieldTileMap
@onready var grid_container: GridContainer = $GridContainer

var generating_terrain : bool = false

func _ready() -> void:
	
	
	draw_cells()
	GameCamera.set_camera_limits(get_rect())


func _on_cell_changed(cell: PlayFieldGridCell) -> void:
	playfield_tile_map.set_pattern(playfield_tile_map.local_to_map(cell.position), playfield_tile_map.tile_set.get_pattern(cell.card_info.pattern))

func draw_cells() -> void:
	for cell in grid_container.get_children():
		cell.queue_free()
	var i_size = to_tilemap(size)
	grid_container.columns = i_size.x 
	for x in i_size.x:
		for y in i_size.y:
			if y % Settings.TILE_SIZE * Settings.CARD_TILE_SIZE:
				var cell = Settings.GRID_CELL.instantiate()
				grid_container.add_child(cell)
				cell.cell_changed.connect(_on_cell_changed)


func to_tilemap(size:  Vector2) -> Vector2i:
	return Vector2i(
		size.x / (Settings.TILE_SIZE * Settings.CARD_TILE_SIZE.x),
		size.y / (Settings.TILE_SIZE * Settings.CARD_TILE_SIZE.y)
	)
