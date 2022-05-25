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

"""
Deck of Cards
"""
var cards_deck = []

"""
Control variables
"""
onready var options_buttons_box = $Options

func _ready():
	
	set_deck_of_cards()
	
	_add_card_to_player()
	_add_card_to_player()
	
func reset_game():
	
	set_deck_of_cards()
	
	player.remove_cards()
	
	_add_card_to_player()
	_add_card_to_player()

"""
Player functions
"""
func _add_card_to_player():
	
	self.player_scoreboard = player.add_card(cards_deck.pop_back())

	_update_player_score_text()

func _update_player_score_text():
	player_score.text = "  Player Score: " + player_scoreboard

"""
Bot functions
"""
func start_bot_turn():
	
	while bot.minimum_score < 21:
		_add_card_to_bot()

func _add_card_to_bot():
	
	self.bot_scoreboard = bot.add_card(cards_deck.pop_back())

	_update_bot_score_text()
	
func _update_bot_score_text():
	bot_score.text = "  Bot Score: " + str(bot_scoreboard)

"""
Card Deck functions
"""

func set_deck_of_cards():
	for type in range(len(Card.CardType.values())):
		for suit in range(len(Card.CardSuits.values())):
			var card_instance : Card = card.instance()
			card_instance.curr_card_suit = suit
			card_instance.curr_card_type = type
			cards_deck.append(card_instance)	
			
	cards_deck.shuffle()

"""
Signal functions
"""
func _on_HitCard_pressed():
	_add_card_to_player()
	
	if player.minimum_score > 21:
		reset_game()
	
func _on_Stop_pressed():
	options_buttons_box.visible = false
	start_bot_turn()
