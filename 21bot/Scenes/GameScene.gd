extends Control

export(PackedScene) var card

"""
Player variables
"""
onready var player       = $Player
onready var player_score = $PlayerScore/Label

var player_scoreboard = 0

"""
Bot variables
"""
onready var bot_score = $"BotScore/Label"

func _ready():
	_add_card()
	_add_card()

func _add_card():
	var card_instance : Card = card.instance()
	card_instance.randomize_card()
	
	

	_update_player_score_text()

func _update_player_score_text():
	player_score.text = "  Player Score: " + str(player_scoreboard)
	
func _update_bot_score_text():
	player_score.text = "  Bot Score: " + str(player_scoreboard)

func _on_HitCard_pressed():
	_add_card()
	
