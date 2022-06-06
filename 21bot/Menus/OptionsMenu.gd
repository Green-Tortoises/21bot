extends Control

onready var model_selector = $Center/OptionsBox/Options/ModelSelection

onready var card_dealing_label = $Center/OptionsBox/Options/CardDealing
onready var card_dealing       = $Center/OptionsBox/Options/CardDealingTimer

var model_controller = ModelController
var settings         = GameSettings

# Called when the node enters the scene tree for the first time.
func _ready():
	
	card_dealing_label.text = "   Card Dealing Timer: " + str(settings.card_timer)
	card_dealing.value      = settings.card_timer
	
	for model in model_controller.AiModels:
		model_selector.add_item(model.replace("_"," "))
		
	model_selector.select(model_controller.selected_model)

func _on_Button_pressed():
	var _err = get_tree().change_scene("res://Menus/MainMenu.tscn")


func _on_ModelSelection_item_selected(index):
	model_controller.selected_model = index
	print(model_controller.selected_model)


func _on_CardDealingTimer_value_changed(value):
	settings.card_timer     = value
	card_dealing_label.text = "   Card Dealing Timer: " + str(settings.card_timer)
