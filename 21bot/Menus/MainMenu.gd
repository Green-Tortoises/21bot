extends Control

func _on_NewGame_pressed():
	var _err = get_tree().change_scene("res://Scenes/GameScene.tscn")

func _on_Settings_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()

