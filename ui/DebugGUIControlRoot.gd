extends Control

const Util = preload("res://util.gd")

func _input(event):
	if event is InputEventMouseMotion:
		$"HexCoords".text = String(Util.cube_to_evenr(Util.pixel_to_cube(event.position, $"../../Map".hexScale)))
		$"HexCoords".update()