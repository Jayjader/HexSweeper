extends Node2D

var hexes = []
const fira_font = preload("res://assets/fira-code-dynamic-font.tres")

func _ready():
	fira_font.size = 10
	fira_font.update_changes()

func _draw():
	for hex in self.hexes:
		var n = hex.neighbors
		if n > 0:
			n = String(n)
			var offset = Transform2D().scaled(0.5 * Vector2(-1, 1)) * fira_font.get_string_size(n)
			offset = offset.snapped(Vector2(1, -1))
			draw_string(fira_font, hex.position + offset, n)
	self.hexes = []