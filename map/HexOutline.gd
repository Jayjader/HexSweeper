tool
extends Node2D

func _draw():
	draw_polyline(get_node("../HexBackground").polygon, Color(0,0,0))