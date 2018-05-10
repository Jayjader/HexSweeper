tool
extends Node2D

enum STATE {
	UNDISCOVERED,
	EMPTY,
	FLAGGED,
	QUESTION_MARK,
	MINE,
	}

var BASE_COLOR
var visual_state

func _ready():
	self.visual_state = STATE.UNDISCOVERED
	self.BASE_COLOR = get_node("HexBackground").color

func _draw():
	get_node("HexBackground")