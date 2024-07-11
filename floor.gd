extends StaticBody2D

@export var floorLevel: String = '0'
@onready var label: Label = $Label
@onready var timer = $Timer
@onready var color_rect = $ColorRect

var rng = RandomNumberGenerator.new()

var isFloorFull: bool = false
var numPassengersOnFloor: int = 0
const MAX_PASSENGERS_ON_FLOOR: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
	label.text = floorLevel
	timer.start(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func generatePassenger():
	var passenger = preload("res://passenger.tscn").instantiate()
	add_child(passenger)
	var tween = get_tree().create_tween()
	tween.tween_property(passenger, "modulate:a", 1, 0.5).set_ease(Tween.EASE_OUT)
	passenger.position.x += 75
	passenger.position.x += (50*numPassengersOnFloor)
	passenger.goalFloor = int(floorLevel)
	while passenger.goalFloor == int(floorLevel):
		passenger.goalFloor = rng.randi_range(1,5)
	passenger.label.text = str(passenger.goalFloor)
	numPassengersOnFloor += 1
	if(get_parent().currentLevel == int(floorLevel) and get_parent().passengerInElevator == false):
		get_parent().get_node("Elevator").checkPassenger()
	
func _on_timer_timeout():
	if rng.randi_range(0, 1) == 1:
		generatePassenger()
		timer.stop()
		if(numPassengersOnFloor < MAX_PASSENGERS_ON_FLOOR):
			timer.start(Global.timeBetweenPassengers)
	else:
		timer.start(Global.timeBetweenPassengers)


func shiftPassengers():
	for child in get_children():
		if child is StaticBody2D:
			var tween = get_tree().create_tween()
			var newPos: Vector2 = Vector2(child.position.x - 50, child.position.y)
			child.animated_sprite_2d.play()
			await tween.tween_property(child, "position", newPos, 0.3).set_ease(Tween.EASE_OUT).finished
			child.animated_sprite_2d.stop()
