extends Node2D

@onready var color_rect = $ColorRect
var colors = [Color.BLUE, Color.RED, Color.GREEN, Color.YELLOW, Color.ORANGE]
var rng = RandomNumberGenerator.new()

var goalFloor: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	if parent.name == "Elevator":
		pass
	var color = colors[rng.randi_range(0, len(colors)-1)]
	modulate = Color(color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
