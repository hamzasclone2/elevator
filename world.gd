extends Node2D

@onready var score_label = $ScoreLabel
@onready var goal_label = $GoalLabel

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label.text = "Score: 0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	score_label.text = "Score: " + str(Global.score)
	
