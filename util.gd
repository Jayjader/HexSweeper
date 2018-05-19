
const cube_directions = [
	Vector3(1, -1, 0), Vector3(1, 0, -1), Vector3(0, 1, -1),
	Vector3(-1, 1, 0), Vector3(-1, 0, 1), Vector3(0, -1, 1),
]

const offset_directions = [
	[ Vector2(1, 0), Vector2(1, -1), Vector2(0, -1),
		Vector2(-1, 0), Vector2(0, 1), Vector2(1, 1) ],
	[ Vector2(1, 0), Vector2(0, -1), Vector2(-1, -1),
		Vector2(-1, 0), Vector2(-1, 1), Vector2(0, 1)]
]

static func axial_to_cube(axial):
	var z = - (axial.x + axial.y)
	return Vector3(axial.x, axial.y, z)

static func cube_to_axial(cube):
	return Vector2(cube.x, cube.y)

static func cube_to_evenr(cube):
	return Vector2(cube.x + (cube.z + (int(cube.z) & 1)) / 2, cube.z)

static func evenr_to_cube(evenr):
	var x = evenr.x - (evenr.y + (int(evenr.y) & 1)) / 2
	var z = evenr.y
	var y = -x-z
	return Vector3(x, y, z)

static func cube_round(cube_float):
	var x = round(cube_float.x)
	var y = round(cube_float.y)
	var z = round(cube_float.z)

	var x_diff = abs(x - cube_float.x)
	var y_diff = abs(y - cube_float.y)
	var z_diff = abs(z - cube_float.z)

	if x_diff > y_diff and x_diff > z_diff:
		x = - y - z
	elif y_diff > z_diff:
		y = - x - z
	else:
		z = - x - y

	return Vector3(x, y, z)

static func cube_neighbors(cube):
	var neighbours = []
	for dir in cube_directions:
		neighbours.append(cube + dir)
	return neighbours

static func offset_neighbor(offset, direction):
	var parity = int(offset.y) & 1
	var dir = offset_directions[parity][direction]
	return offset + dir

static func offset_neighbors(offset):
	var neighbors = []
	for dir in range(6):
		neighbors.append(offset_neighbor(offset, dir))
	return neighbors

static func pixel_to_cube(point, hexScale):
	var q = (sqrt(3) * point.x / 3 - point.y / 3) / hexScale
	var r = (2 * point.y / 3) / hexScale
	return cube_round(Vector3(q, - q - r, r))
