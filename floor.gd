extends StaticBody2D

@export var floorLevel: String = '0'
@onready var label: Label = $Label
@onready var timer = $Timer

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)
	label.text = floorLevel
	generatePassenger()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	#if Global.is_dragging:
		#visible = true
	#else:
		#visible = false

func generatePassenger():
	var passenger = preload("res://passenger.tscn").instantiate()
	add_child(passenger)
	passenger.position.x += 75
	passenger.goalFloor = int(floorLevel)
	while passenger.goalFloor == int(floorLevel):
		passenger.goalFloor = rng.randi_range(1,5)
	passenger.label.text = str(passenger.goalFloor)


func _on_timer_timeout():
	if rng.randi_range(0, 1) == 1:
		generatePassenger()
		print("Floor Level: ", floorLevel, " has generated a passenger")
		timer.stop()
	else:
		timer.start(3)
		print("Floor Level: ", floorLevel, " has reset the timer")
