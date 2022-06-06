extends Node

enum AiModels {
	Expectiminimax,
	Genetic_Algorithm
	Counting_Card
}

const AI_FOLDER = "AI"

var selected_model = AiModels.Expectiminimax

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func predict():
	pass
	
func run_ai():
	var python_script_path = AI_FOLDER + "/" + str(AiModels.keys()[selected_model]) + ".py"
	var python_output = []
	var python_arguments = ["kkkkk olha o corno", ":-)"]
	var err = OS.execute("python", [python_script_path,python_arguments], true, python_output, true)
	
	if err != 0:
		printerr("ERROR! no such python script: ", python_script_path, " exist")
		
	return python_output
