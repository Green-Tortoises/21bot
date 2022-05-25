extends Control

onready var model_selector = $Center/OptionsBox/Options/ModelSelection

var model_controller = ModelController

# Called when the node enters the scene tree for the first time.
func _ready():
	for model in model_controller.AiModels:
		model_selector.add_item(model)
		
	model_selector.select(model_controller.selected_model)

func _on_Button_pressed():
	var _err = get_tree().change_scene("res://Menus/MainMenu.tscn")


func _on_ModelSelection_item_selected(index):
	model_controller.selected_model = index
	print(model_controller.selected_model)
