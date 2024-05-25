extends Node2D

@onready var score_label = $ScoreLabel
@onready var goal_label = $GoalLabel
@onready var timer = $Timer

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label.text = "Score: 0"
	Global.goalLevel = rng.randi_range(1,5)
	goal_label.text = "Goal: " + str(Global.goalLevel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	score_label.text = "Score: " + str(Global.score)

func _on_timer_timeout():
	var previousGoalLevel = Global.goalLevel
	while(previousGoalLevel == Global.goalLevel):
		Global.goalLevel = rng.randi_range(1,5)
	goal_label.text = "Goal: " + str(Global.goalLevel)
	timer.start(5)
