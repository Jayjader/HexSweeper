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
var highlighted

func _ready():
	self.visual_state = STATE.UNDISCOVERED
	self.BASE_COLOR = get_node('HexBackground').color

func highlight():
	self.highlighted = not self.highlighted
	$"HexBackground".color = BASE_COLOR.lightened(0.2) if self.highlighted else BASE_COLOR
	$"HexBackground".update()