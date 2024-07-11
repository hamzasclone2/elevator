extends Node2D

@onready var score_label = $ScoreLabel
@onready var timer = $Timer
@onready var time_label = $TimeLabel

var rng = RandomNumberGenerator.new()
var time_in_seconds: int = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label.text = "Score: 0"
	timer.wait_time = time_in_seconds
	timer.start()
	time_label.text = "Time: " + str(int(timer.time_left))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	score_label.text = "Score: " + str(Global.score)
	time_label.text = "Time: " + str(int(timer.time_left))
	


func _on_timer_timeout():
	score_label.text = "Final Score: " + str(Global.score)
	get_tree().paused = true
	
