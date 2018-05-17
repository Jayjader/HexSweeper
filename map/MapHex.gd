tool
extends Node2D

enum STATE {
	UNDISCOVERED,
	EMPTY,
	FLAGGED,
	QUESTION_MARK,
	MINE,
	}

onready var BASE_COLOR = get_node('HexBackground').color
var visual_state setget set_state
var highlighted
var mine
var neighbors = -1

func _ready():
	self.visual_state = STATE.UNDISCOVERED

func highlight():
	self.highlighted = not self.highlighted
	$"HexBackground".color = BASE_COLOR.lightened(0.2) if self.highlighted else BASE_COLOR
	$"HexBackground".update()

func reveal():
	if self.visual_state == STATE.UNDISCOVERED:
		self.visual_state = STATE.MINE if self.mine else STATE.EMPTY

func set_state(new_state):
	visual_state = new_state
	match new_state:
		STATE.UNDISCOVERED:
			$"HexBackground".color = BASE_COLOR
		STATE.EMPTY:
			$"HexBackground".color = Color("663300")
