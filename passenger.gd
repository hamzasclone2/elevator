extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var color_rect = $ColorRect
var colors = [Color.BLUE, Color.RED, Color.GREEN, Color.YELLOW, Color.ORANGE]
var rng = RandomNumberGenerator.new()
@onready var label = $Label
var numSprites: int = 6

var goalFloor: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var temp = rng.randi_range(0, numSprites-1)
	animated_sprite_2d.animation = "passenger" + str(temp)
	var parent = get_parent()
	if parent.name == "Elevator":
		pass
	var color = colors[rng.randi_range(0, len(colors)-1)]
	color_rect.color = Color(color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
