extends Control
class_name Card

enum CardSuits {
	Hearts,
	Diamonds,
	Clubs,
	Spades 
}

enum CardType {
	Ace,
	Two,
	Three,
	Four,
	Five,
	Six,
	Seven,
	Eight,
	Nine,
	Jack,
	Queen,
	King
}

export(CardSuits) var curr_card_suit = CardSuits.Hearts setget set_card_suit
export(CardType) var curr_card_type = CardType.Ace setget set_card_type

onready var card_sprite = $Sprite

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	card_sprite.frame = curr_card_suit * 13 + curr_card_type
	
func get_card_type() -> int:
	return curr_card_type
	
func randomize_card() -> void:
	rng.randomize()
	curr_card_suit = rng.randi_range(0,CardSuits.size()-1)
	curr_card_type = rng.randi_range(0,CardType.size()-1)
	
func set_card_suit(card_suit : int) -> void:
	curr_card_suit = card_suit
	
func set_card_type(card_type : int) -> void:
	curr_card_type = card_type
	
func _set_card() -> void:
	card_sprite.frame = curr_card_suit * 13 + curr_card_type
	
func toMap() -> Dictionary:
	
	var card_value = convert_card_value_to_int(curr_card_type)
	
	if curr_card_type == CardType.Ace:
		card_value = 11
	
	return {
		"type"  : curr_card_type,
		"suit"  : CardSuits.keys()[curr_card_suit],
		"value" : card_value
	}
	
static func convert_card_value_to_int(card_value):
	return int(min(card_value,9) + 1)
