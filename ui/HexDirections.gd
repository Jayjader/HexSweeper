extends Control

const Util = preload('res://util.gd')
const fira_font = preload('res://assets/fira-code-dynamic-font.tres')

var text_color = Color('#ffa500')
var hover_hex_offset_coords = Vector2()

func _ready():
	fira_font.size = 10
	fira_font.update_changes()

func _draw():
	var map = $"../../../Map"
	for d in range(6):
		var neighbor_offset = Util.offset_neighbor(hover_hex_offset_coords, d)
		if map.is_on_map(neighbor_offset):
			var label_position = map._map[neighbor_offset].position
			var hover_position = map._map[self.hover_hex_offset_coords].position
			label_position += 0.25 * (hover_position - label_position)
			d = String(d)
			draw_string(fira_font, label_position + Util.char_offset(fira_font, d), d, text_color)