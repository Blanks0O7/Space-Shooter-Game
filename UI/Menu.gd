extends Control

func _ready():
	$VBoxContainer/Start.grab_click_focus()


func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Gameplay.tscn")


func _on_Settings_pressed():
	get_tree().change_scene("res://UI/Settings.tscn")


func _on_Quit_pressed():
	get_tree().quit()
