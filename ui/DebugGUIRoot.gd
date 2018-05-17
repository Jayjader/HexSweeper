extends Node

func _input(event):
	if event.is_action("debug_toggle") && event.is_pressed():
		var gui_root = $"DebugGUIControlRoot"
		gui_root.visible = !gui_root.visible
		gui_root.update()
		get_tree().set_input_as_handled()
		print('toggle debug: ', gui_root.visible)
