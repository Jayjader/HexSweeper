tool
extends Node2D

const Util = preload("res://util.gd")

enum STATE {
	UNDISCOVERED,
	EMPTY,
	FLAGGED,
	QUESTION_MARK,
	MINE,
	}

onready var BASE_COLOR = get_node('HexBackground').color
var visual_state setget set_state
var highlighted setget _highlight
var _highlighted = false
var mine = false
var flag = false
var neighbors = 0
var offset_position setget _set_offset_position, _get_offset_position
var cube_position setget _set_cube_position, _get_cube_position
var _offset_position
var _cube_position

func _get_offset_position():
	return self._offset_position

func _get_cube_position():
	return self._cube_position

func _set_offset_position(offset):
	self._offset_position = offset
	self._cube_position = Util.evenr_to_cube(offset)

func _set_cube_position(cube):
	self._cube_position = cube
	self._offset_position = Util.cube_to_evenr(cube)

func _ready():
	self.visual_state = STATE.UNDISCOVERED

func _highlight():
	highlighted = not self.highlighted
	$"HexBackground".color = BASE_COLOR.lightened(0.2) if self.highlighted else BASE_COLOR
	$"HexBackground".update()

func reveal():
	if self.visual_state == STATE.UNDISCOVERED:
		self.visual_state = STATE.MINE if self.mine else STATE.EMPTY
	return self.visual_state != STATE.MINE

func set_state(new_state):
	visual_state = new_state
	match new_state:
		STATE.UNDISCOVERED:
			$"HexBackground".color = BASE_COLOR
		STATE.EMPTY:
			$"HexBackground".color = Color("663300")
		STATE.MINE:
			$"HexBackground".color = Color(1, 0, 0)
