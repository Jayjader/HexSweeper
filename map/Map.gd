tool
extends Node2D

export (int) var width
export (int) var height
export (int) var hexScale

var _map = {}

var hexHeight = 2
var hexWidth = sqrt(3)

var yDistBetweenHexes = .75 * hexHeight

func xOffset(rowNumber):
	return -.5 * hexWidth * (rowNumber % 2)

func _ready():
	for y in range(height):
		for x in range(width):
			var hex = preload("res://map/MapHex.tscn").instance()
			add_child(hex)
			hex.transform = hex.transform.translated(Vector2(hexWidth * x + xOffset(y), yDistBetweenHexes * y))
			hex.transform = hex.transform.scaled(hexScale * Vector2(1, 1))
			_map[Vector2(x, y)] = hex
