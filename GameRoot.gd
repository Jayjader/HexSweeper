extends Node

func _ready():
	for hex in $"Map"._map.values():
		hex.connect("game_over", $"EndGameGuiControlRoot", "toggle")