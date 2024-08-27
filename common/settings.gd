extends Node



const GRID_CELL = preload("res://playfield/grid_cell.tscn")
const CARD_EFFECT = preload("res://cards/scenes/card_effect_scene.tscn")
const TILESET = preload("res://common/tiles.tres")
const CARD = preload("res://cards/scenes/card2d_scene.tscn")
const CARD_TILE_SIZE = Vector2i(5, 3)
const DEBUG : bool = true
const TILE_SIZE : int = 10
