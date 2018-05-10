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

func handleClick():
	pass

var visual_state

func _ready():
	visual_state = STATE.UNDISCOVERED
	BASE_COLOR = get_node("HexBackground").color

func _draw():
	get_node("HexBackground")