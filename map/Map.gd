tool
extends Node2D

const Util = preload("res://util.gd")
const fira_font = preload("res://assets/fira-code-dynamic-font.tres")

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
	fira_font.size = 10
	fira_font.update_changes()

	for y in range(self.height):
		for x in range(self.width):
			var hex = preload("res://map/MapHex.tscn").instance()
			hex.transform = hex.transform.translated(Vector2(
				self.hexWidth * x + self.xOffset(y), self.yDistBetweenHexes * y))
			hex.transform = hex.transform.scaled(hexScale * Vector2(1, 1))
			hex.mine = randf() > 0.5
			self._map[Vector2(x, y)] = hex
			self.add_child(hex, true)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.is_pressed():
			var click_position = self.get_local_mouse_position()
			var hex = Util.cube_to_evenr(Util.pixel_to_cube(click_position, self.hexScale))
			if 0 <= hex.x && hex.x < width:
				if 0 <= hex.y && hex.y < height:
					self._map[hex].reveal()
					update()

func _draw():
	for hex in self._map.values():
		if hex.visual_state == hex.STATE.EMPTY:
			$"MapOverlay".hexes.append(hex)
			# draw_string(fira_font, hex.position, "TEST STRING")
	$"MapOverlay".update()