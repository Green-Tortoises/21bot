extends Node

enum AiModels {
	Expectimax,
	Counting_Card
}

enum Actions {
	Hit,
	Stand
}

enum Agents {
	player,
	enemy
}

const AI_FOLDER = "Singleton/AI"

var selected_model = AiModels.Expectimax

func predict(player : Player, opponent : Player):
	
	var movement = Actions.Hit
	
	match selected_model:
		
		AiModels.Expectimax:
			
			movement = expectimax(player,opponent)
			
		AiModels.Counting_Card:
			
			movement = counting_card(player,opponent)
			
	return movement

"""
func run_ai():
	var python_script_path = AI_FOLDER + "/" + str(AiModels.keys()[selected_model]) + ".py"
	var python_output = []
	var python_arguments = [1,2]
	var err = OS.execute("python", [python_script_path,python_arguments], true, python_output, true)
	
	if err != 0:
		printerr("ERROR! no such python script: ", python_script_path, " exist")
		
	return python_output
"""
"""
Expectimax
"""
	
func expectimax(player : Player,opponent : Player ):
	
	# Average value of a card in a deck
	var average_value = float(4*(1+2+3+4+5+6+7+8+9+10*4))/float(52)

	var dealer_hand_value = opponent.get_hand_value()

	while dealer_hand_value < 17:
		dealer_hand_value += average_value

	var player_hand       = player.cards_list
	var player_hand_value = player.get_hand_value()
	
	var result = overall(player_hand_value,Agents.player,false,dealer_hand_value)
	var action = 0
	
	if len(result) > 1:
		action = result[1]
	else :
		action = abs(result[0])
		
	return action 
	
func overall(state, agent, pStand, dealerVal):
	if pStand or state > 21:
		var pBust = state > 21
		if pBust:
			return [-1]
		elif dealerVal > 21:
			return [1]
		elif dealerVal > state:
			return [-1]
		elif state > dealerVal:
			return [1]
		else:
			return [0]

	if agent == Agents.player:
		return max_value(state, agent, pStand, dealerVal)
	else:
		return expected_value(state, agent, pStand, dealerVal)
	
func max_value(state, agent, pStand, dealerVal):
	# initialize a highschore (in a list so we can add optimal action)
	var highScore = [-2.802597e-45]

	var actions = Actions.values()

	# keep the max action score of the actions
	for action in actions:
		var nS = generate_successor(state, pStand, action)
		var score = overall(nS[0], 1, nS[1], dealerVal)
		if score[0] >= highScore[0]:
			highScore = [score[0], action]
	return highScore
	
func expected_value(state, agent, pStand, dealerVal):
	var highScore = [0]
	
	var actions = Actions.values()

	# accumulate expected val of actions
	for action in actions:
		var nS = generate_successor(state, pStand, action)
		var score = overall(nS[0], 1, nS[1], dealerVal)
		highScore[0] += float(score[0])/float(len(actions))
		# print(state.getPlayerHands() == og, '****')
	return highScore
	
func generate_successor(state, pStand, action):
	var averageValue = float(4*(1+2+3+4+5+6+7+8+9+10*4))/float(52)
	var newState = 0
	var newStand = 0
	if action == Actions.Hit:
		newState = state + averageValue
		newStand = pStand
	if action == Actions.Stand:
		newStand = true
		newState = state
	return [newState, newStand]

"""
Counting Card with Hi-low
"""

var CARD_VALUES = [ 1,
	1,
	1,
	1,
	1,
	0,
	0,
	0,
	-1,
	-1,
	-1,
	-1,
]

func counting_card(player : Player,opponent : Player):
	return player_move(player.cards_list, 21, card_counter(player.cards_list), opponent.cards_list)

func card_counter(hand):
	var count = 0
	for card in hand:
		count += CARD_VALUES[card["type"]]
	return count

func hand_total(hand):
	var sum = 0
	
	for card in hand:
		sum += card["value"]
		
	return sum

func player_move(player_hand, limit, true_count, dealer_hand):
	
	var dtotal = hand_total(dealer_hand)

	var player_hand_total = hand_total(player_hand)

	if true_count > 0:
		if player_hand_total >= limit:
			return Actions.Stand
		elif player_hand_total  < limit:
			return Actions.Hit
		elif dtotal >= 10:
			return Actions.Stand
		
	elif true_count < 0:
		if player_hand_total <= limit:
			return Actions.Hit
		elif player_hand_total > limit:
			return Actions.Stand
		elif dtotal < 10:
			return Actions.Hit
	
	else:
		if player_hand_total >= 17:
			return Actions.Stand
		elif player_hand_total < 17:
			return Actions.Hit
