extends Node2D

var new_revealed_hexes = []
var new_flagged_hexes = []
const Util = preload('res://util.gd')
const fira_font = preload('res://assets/fira-code-dynamic-font.tres')
const flag_char = 'F'

func _ready():
	fira_font.size = 10
	self.fira_font.update_changes()

func _draw():
	for hex in self.new_revealed_hexes:
		var n = hex.neighbors
		if n > 0:
			n = String(n)
			draw_string(fira_font, hex.position + Util.char_offset(fira_font, n), n)

	for hex in self.new_flagged_hexes:
		draw_string(fira_font, hex.position + Util.char_offset(fira_font, self.flag_char), self.flag_char)

	self.new_revealed_hexes = []
	self.new_flagged_hexes = []