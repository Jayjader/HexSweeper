extends Control

func toggle():
	var popup = $"EndGameDialogue"
	if popup.visible:
		popup.visible = false
	else:
		popup.popup()
