extends Node

func _input(event):
	if event.is_action("debug_toggle") && event.is_pressed():
		var gui_root = get_node("DebugGUIControlRoot")
		gui_root.visible = !gui_root.visible
		gui_root.update()
		get_tree().set_input_as_handled()
