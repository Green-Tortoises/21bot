extends VBoxContainer
class_name Player

onready var cards = $Cards

var scoreboard : String  = ""
var minimum_score : int = 0
var maximum_score : int = 0

const ACE_MINIMUM_VALUE = 1
const ACE_MAXIMUM_VALUE = 11

var number_of_cards = 0

var cards_list = [] setget , get_cards_list

func remove_cards():
	
	self.minimum_score = 0
	self.maximum_score = 0
	cards_list.clear()
	
	for card in cards.get_children():
		cards.remove_child(card)
		card.queue_free()

func add_card(card : Card) -> String:

	cards.add_child(card)
	cards_list.append(card.toMap())
	number_of_cards += 1
	cards.alignment = 1 # AlignCenter	
	
	var card_type = card.get_card_type()

	var card_score = Card.convert_card_value_to_int(card_type)

	if card_type == Card.CardType.Ace:
		
		#print(minimum_score)
		#rint(maximum_score)
		
		if maximum_score + 11 <= 21:
			minimum_score += ACE_MINIMUM_VALUE
			maximum_score += ACE_MAXIMUM_VALUE
			scoreboard = str(minimum_score) + "/" + str(maximum_score)

		else:
			minimum_score += card_score
			maximum_score += card_score
			scoreboard = str(minimum_score)
	else:
		
		#print(minimum_score)
		#print(maximum_score)
		
		#print(maximum_score + card_score)
		
		if maximum_score != minimum_score and maximum_score + card_score <= 21:
			
			minimum_score += card_score
			maximum_score += card_score
			scoreboard = str(minimum_score) + "/" + str(maximum_score)
			
		else:
			
			minimum_score += card_score
			maximum_score = minimum_score
			scoreboard = str(minimum_score)

	return scoreboard

func get_cards_list():
	return cards_list.duplicate(true)
	
func get_hand_value():
	var sum = 0
	
	for card in cards_list:
		sum += card["value"]
		
	return sum

func get_hand_value_list():
	var cards = []
	
	for card in cards_list:
		cards.append(card["value"])
		
	return cards
