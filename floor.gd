extends StaticBody2D

@export var floorLevel: String = '0'
@onready var label: Label = $Label
@onready var timer = $Timer

var rng = RandomNumberGenerator.new()

var isFloorFull: bool = false
var numPassengersOnFloor: int = 0
const MAX_PASSENGERS_ON_FLOOR: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)
	label.text = floorLevel
	timer.start(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func generatePassenger():
	var passenger = preload("res://passenger.tscn").instantiate()
	add_child(passenger)
	passenger.position.x += 75
	passenger.position.x += (50*numPassengersOnFloor)
	passenger.goalFloor = int(floorLevel)
	while passenger.goalFloor == int(floorLevel):
		passenger.goalFloor = rng.randi_range(1,5)
	passenger.label.text = str(passenger.goalFloor)
	numPassengersOnFloor += 1
	
func _on_timer_timeout():
	if rng.randi_range(0, 1) == 1:
		generatePassenger()
		timer.stop()
		if(numPassengersOnFloor < MAX_PASSENGERS_ON_FLOOR):
			timer.start(5)
	else:
		timer.start(5)
		#print("Floor Level: ", floorLevel, " has reset the timer")

func shiftPassengers():
	for child in get_children():
		if child is StaticBody2D:
			child.position.x -= 50
