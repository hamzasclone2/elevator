extends Node2D

var draggable: bool = false
var is_inside_droppable: bool = false
var body_ref: StaticBody2D
var offset: Vector2
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	
	if draggable:
		if Input.is_action_just_pressed("click"):
			offset = get_global_mouse_position() - global_position
			get_parent().is_dragging = true
		if Input.is_action_pressed("click"):
			global_position.y = get_global_mouse_position().y - offset.y
		elif Input.is_action_just_released("click"):
			get_parent().is_dragging = false
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
			get_parent().currentLevel = body_ref.get_node("Label").text
			dropOff()
			checkPassenger()



func _on_area_2d_mouse_entered():
	if not get_parent().is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited():
	if not get_parent().is_dragging:
		draggable = false
		scale = Vector2(1, 1)
	
func _on_area_2d_body_entered(body):
	if body.is_in_group('droppable'):
		is_inside_droppable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group('droppable'):
		is_inside_droppable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)

func checkPassenger():
	if not get_parent().passengerInElevator and body_ref.numPassengersOnFloor > 0:
		#var passenger = body_ref.get_node("Passenger")
		var passenger = getFirstPassenger(body_ref)
		body_ref.remove_child(passenger)
		add_child(passenger)
		passenger.position.x = sprite_2d.position.x - 15
		passenger.position.y = sprite_2d.position.y - 15
		get_parent().passengerInElevator = true
		body_ref.numPassengersOnFloor -= 1
		body_ref.shiftPassengers()
		body_ref.timer.start(5)
		
func dropOff():
	if get_parent().passengerInElevator:
		var passenger = getFirstPassenger(self)
		if get_parent().currentLevel == passenger.goalFloor:
			remove_child(passenger)
			passenger.queue_free()
			get_parent().passengerInElevator = false
			Global.score += 1
			var tween = get_tree().create_tween()
			tween.tween_property(label, "modulate:a", 1, 0.5).set_ease(Tween.EASE_OUT)
			tween.tween_property(label, "modulate:a", 0, 0.5).set_ease(Tween.EASE_IN)
			
		
func getFirstPassenger(floor_level):
	for child in floor_level.get_children():
		if child is StaticBody2D:
			return child
	
