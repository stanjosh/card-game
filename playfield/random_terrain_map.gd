extends TileMapLayer
class_name RandomTerrainMap

@export var terrain : int = 0
@export var terrain_type : int = 0
@export var terrain_offset : Vector3 = Vector3.ZERO


@export var terrain_noise : FastNoiseLite = FastNoiseLite.new() :
	set(value):
		terrain_noise = value
		if terrain_noise and !terrain_noise.changed.is_connected(generate_terrain):
			terrain_noise.changed.connect(generate_terrain)

@export_range(-1, 1) var terrain_level : float = 0.2 :
	set(value):
		terrain_level = value
		if is_node_ready():
			generate_terrain()

var generating_terrain : bool = false

func _ready() -> void:

	generate_terrain()

func _process(delta: float) -> void:
	generating_terrain = false

func generate_terrain():
	terrain_noise.offset = terrain_offset
	terrain_noise.frequency = terrain_offset.z
	if not generating_terrain:
		generating_terrain = true
		clear()
		var waters : Array[Vector2i]
		for x in Playfield.size.x / Settings.TILE_SIZE:
			for y in Playfield.size.y / Settings.TILE_SIZE:
				if terrain_noise.get_noise_2d(x, y) < terrain_level:
					waters.push_back(Vector2i(x, y))
		set_cells_terrain_connect(waters, terrain, terrain_type)
