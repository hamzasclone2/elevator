extends StaticBody2D

@export var floorLevel: String = '0'
@onready var label: Label = $Label

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)
	label.text = floorLevel
	generatePassenger()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.is_dragging:
		visible = true
	else:
		visible = false

func generatePassenger():
	var passenger = preload("res://passenger.tscn").instantiate()
	add_child(passenger)
	passenger.position.x += 75
	passenger.goalFloor = int(floorLevel)
	while passenger.goalFloor == int(floorLevel):
		passenger.goalFloor = rng.randi_range(1,5)
