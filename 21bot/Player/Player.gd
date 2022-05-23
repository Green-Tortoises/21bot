extends VBoxContainer
class_name Player

onready var cards = $Cards

var scoreboard : String  = ""
var scoreboard_int : int = 0

func _ready():
	pass # Replace with function body.

func add_card(card : Card) -> String:

	cards.add_child(card)
	cards.alignment = 1 # AlignCenter	
	
	var card_type = card.get_card_type()

	var card_score = convert_card_value_to_int(card_type)

	if card_type == Card.CardType.Ace:
		
		if scoreboard_int <= 10:
			scoreboard = str(scoreboard_int + card_score) + "/" + str(scoreboard_int + 11)
			scoreboard_int += 11 
		else:
			scoreboard = str(scoreboard_int + card_score)
			scoreboard_int += card_score
	else:
		scoreboard = str(scoreboard_int + card_score)
		scoreboard_int += card_score

	return scoreboard

	
func convert_card_value_to_int(card_value):
	return int(min(card_value,9) + 1)
