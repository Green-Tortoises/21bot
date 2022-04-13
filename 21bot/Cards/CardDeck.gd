extends Node
class_name CardDeck

export(PackedScene) var card_template

var cards : Array = []

func _ready():
	print(card_template.CardType.size())
	
