extends Control

func _ready():
	print(ModelController.run_ai())

func _on_NewGame_pressed():
	var _err = get_tree().change_scene("res://Scenes/GameScene.tscn")

func _on_Settings_pressed():
	var _err = get_tree().change_scene("res://Menus/OptionsMenu.tscn")

func _on_Quit_pressed():
	get_tree().quit()

