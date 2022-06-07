extends Control

export(PackedScene) var card
export(PackedScene) var game_over_scene

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
	randomize()
	
	set_deck_of_cards()
	
	_initial_draw()

func _initial_draw():

	_add_card_to_player()
	_add_card_to_player()
	
	_add_card_to_bot()
	_add_card_to_bot()
	
func _reset_game():
	
	set_deck_of_cards()
	
	player.remove_cards()
	bot.remove_cards()
	
	bot_scoreboard    = "0"
	_update_bot_score_text()
	
	options_buttons_box.visible = true
	
	_initial_draw()

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
	
	while ModelController.predict(bot,player) == ModelController.Actions.Hit:
		_add_card_to_bot()
		yield(get_tree().create_timer(GameSettings.card_timer), "timeout")
		
	var winner = GameOver.State.PlayerWins
		
	if bot.minimum_score <= 21 and bot.maximum_score > player.maximum_score:
		winner = GameOver.State.BotWins
		
	_show_game_over_screen(winner)

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
		_show_game_over_screen(GameOver.State.BotWins)
		
func _on_Stop_pressed():
	options_buttons_box.visible = false
	start_bot_turn()

"""
Keyboard input handling
"""
func _input(event):
	
	if event.is_action_pressed("ui_home"):
		_quit_game()

func _quit_game():
	var _err = get_tree().change_scene("res://Menus/MainMenu.tscn")
	
func _show_game_over_screen(winner):
	var game_over_scene_instance : GameOver = game_over_scene.instance()
		
	var _err  = game_over_scene_instance.connect("reset_game",self,"_reset_game")
	var _err2 = game_over_scene_instance.connect("quit_game",self,"_quit_game")
	
	game_over_scene_instance.winner = winner
	
	get_tree().get_root().call_deferred("add_child",game_over_scene_instance)
	
