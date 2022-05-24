extends Control

export(PackedScene) var card

"""
Player variables
"""
onready var player       = $Player
onready var player_score = $PlayerScore/Label

var player_scoreboard : String

"""
Bot variables
"""
onready var bot       = $Bot
onready var bot_score = $BotScore/Label

var bot_scoreboard : String

func _ready():
	_add_card_to_player()
	_add_card_to_player()
	
func reset_game():
	
	player.remove_cards()
	
	_add_card_to_player()
	_add_card_to_player()

func _add_card_to_player():
	var card_instance : Card = card.instance()
	card_instance.randomize_card()
	
	self.player_scoreboard = player.add_card(card_instance)

	_update_player_score_text()

func _add_card_to_bot():
	var card_instance : Card = card.instance()
	card_instance.randomize_card()
	
	self.bot_scoreboard = bot.add_card(card_instance)

	_update_bot_score_text()


func _update_player_score_text():
	player_score.text = "  Player Score: " + player_scoreboard
	
func _update_bot_score_text():
	bot_score.text = "  Bot Score: " + str(bot_scoreboard)

func _on_HitCard_pressed():
	_add_card_to_player()
	
	if player.minimum_score > 21:
		reset_game()
	
func _on_Stop_pressed():
	_add_card_to_bot()
