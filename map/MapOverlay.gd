extends Node2D

var hexes = []
const fira_font = preload("res://assets/fira-code-dynamic-font.tres")

func _ready():
    fira_font.size = 10
    fira_font.update_changes()

func _draw():
    for hex in self.hexes:
        draw_string(fira_font, hex.position, String(hex.neighbors))
    self.hexes = []