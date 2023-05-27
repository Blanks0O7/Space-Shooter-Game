extends CanvasLayer





func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Gameplay.tscn")


func _on_Quit_pressed():
	get_tree().quit()
