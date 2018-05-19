extends Node2D

var new_revealed_hexes = []
var new_flagged_hexes = []
const fira_font = preload('res://assets/fira-code-dynamic-font.tres')
const flag_char = 'F'

func char_offset(c):
	return (Transform2D().scaled(0.5 * Vector2(-1, 1)) * fira_font.get_string_size(c)).snapped(Vector2(1, -1))

func _ready():
	fira_font.size = 10
	fira_font.update_changes()

func _draw():
	for hex in self.new_revealed_hexes:
		var n = hex.neighbors
		if n > 0:
			n = String(n)
			draw_string(fira_font, hex.position + self.char_offset(n), n)

	for hex in self.new_flagged_hexes:
		draw_string(fira_font, hex.position + self.char_offset(self.flag_char), self.flag_char)

	self.new_revealed_hexes = []
	self.new_flagged_hexes = []