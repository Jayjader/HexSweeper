extends Control

signal pause_game
signal resume_game

func toggle():
	$"EndGameDialogue".popup()
	if $"EndGameDialogue".visible:
		emit_signal("pause_game")
	else:
		emit_signal("resume_game")
