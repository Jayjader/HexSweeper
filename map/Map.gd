extends Node2D

const Util = preload("res://util.gd")
const fira_font = preload("res://assets/fira-code-dynamic-font.tres")

export (int) var width
export (int) var height
export (int) var hexScale

onready var x_bounds = [0, width]
onready var y_bounds = [0, height]
var _map = {}
var hexHeight = 2
var hexWidth = sqrt(3)
var yDistBetweenHexes = .75 * hexHeight
var pause = false

func xOffset(rowNumber):
	return -.5 * hexWidth * (rowNumber % 2)

func is_on_map(offset):
	return offset.x >= self.x_bounds[0] && offset.x < self.x_bounds[1] && offset.y >= self.y_bounds[0] && offset.y < self.y_bounds[1]

func reveal(offsets):
	match offsets:
		[]:
			pass
		[var offset, ..]:
			var hex = self._map[offset]

			if hex.visual_state == hex.STATE.UNDISCOVERED && !hex.flag:
				if hex.reveal() && hex.neighbors == 0:
					for n in Util.offset_neighbors(hex.offset_position):
						if self.is_on_map(n):
							offsets.append(n)

			offsets.pop_front()
			self.reveal(offsets)

func generate():
	for y in range(self.height):
		for x in range(self.width):
			var hex = preload("res://map/MapHex.tscn").instance()

			hex.offset_position = Vector2(x, y)
			hex.transform = hex.transform.translated(Vector2(self.hexWidth * x + self.xOffset(y), self.yDistBetweenHexes * y))
			hex.transform = hex.transform.scaled(hexScale * Vector2(1, 1))
			hex.mine = randf() > 0.8
			hex.connect("game_over", $"../EndGameGuiControlRoot", "toggle")

			self._map[Vector2(x, y)] = hex
			self.add_child(hex, true)

	for hex in self._map.values():
		for neighbor in Util.offset_neighbors(hex.offset_position):
			if self.is_on_map(neighbor) && self._map[neighbor].mine:
				hex.neighbors += 1

func _on_NewGameButton_pressed():
	self.generate()
	self.update()
	self.pause = false

func _ready():
	fira_font.size = 10
	fira_font.update_changes()

	self.generate();

func _input(event):
	if self.pause:
		pass
	else:
		if event is InputEventMouseButton && event.is_pressed():
			var click_position = self.get_local_mouse_position()
			var hex_offset = Util.cube_to_evenr(Util.pixel_to_cube(click_position, self.hexScale))

			if self.is_on_map(hex_offset):
				if event.button_index == BUTTON_LEFT:
					self.reveal([hex_offset])
					update()

				elif event.button_index == BUTTON_RIGHT:
					var hex = self._map[hex_offset]

					if hex.visual_state == hex.STATE.UNDISCOVERED:
						hex.flag = !hex.flag

					elif hex.visual_state == hex.STATE.EMPTY:
						var to_reveal = []
						var neighbors = 0

						for neighbor in Util.offset_neighbors(hex_offset):
							if self.is_on_map(neighbor):
								neighbors += 1

								if !self._map[neighbor].flag:
									to_reveal.append(neighbor)

						if neighbors - to_reveal.size() == hex.neighbors:
							self.reveal(to_reveal)

					update()


func _draw():
	for hex in self._map.values():
		if hex.visual_state == hex.STATE.EMPTY:
			$"MapOverlay".new_revealed_hexes.append(hex)

		elif hex.flag:
			$"MapOverlay".new_flagged_hexes.append(hex)

	$"MapOverlay".update()
