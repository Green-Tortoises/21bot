extends Control

export(PackedScene) var card

onready var player       = $Player
onready var player_cards = $Player/Cards

func _on_HitCard_pressed():
	var card_instance : Card = card.instance()
	card_instance.randomize_card()
	
	player_cards.add_child(card_instance)
	player_cards.alignment = 1 # AlignCenter
	
