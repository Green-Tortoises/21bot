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
	
func get_card_value() -> int:
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
