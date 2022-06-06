extends Control
class_name GameOver

signal quit_game
signal reset_game

enum State {
	BotWins,
	PlayerWins,
}

export(State) var winner = State.PlayerWins setget set_winner

onready var label = $GameOverLabel

func _ready():
	if winner == State.PlayerWins:
		label.text = "YOU WIN"
		label.set("custom_colors/font_color", Color(0,1,0))
	else:
		label.text = "YOU LOSE"
		label.set("custom_colors/font_color", Color(1,0,0))
	
	get_tree().paused = true

func set_winner(new_winner):
	winner = new_winner

func _on_Reset_pressed():
	get_tree().paused = false
	emit_signal("reset_game")
	self.queue_free()

func _on_Quit_pressed():
	get_tree().paused = false
	emit_signal("quit_game")
	self.queue_free()
