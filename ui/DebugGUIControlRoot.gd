extends Control

const Util = preload("res://util.gd")

var hover_offset_coords = Vector2()

func _input(event):
	if event is InputEventMouseMotion:
		var new_hover_offset_coords = Util.cube_to_evenr(Util.pixel_to_cube(event.position, $"../../Map".hexScale))
		if $"../../Map".is_on_map(new_hover_offset_coords) && self.hover_offset_coords != new_hover_offset_coords:
			self.hover_offset_coords = new_hover_offset_coords
			$"HexCoords".text = String(self.hover_offset_coords)
			$"HexCoords".update()
			$"HexDirections".hover_hex_offset_coords = self.hover_offset_coords
			$"HexDirections".update()