extends Node2D

var draggable = false
var is_inside_droppable = false
var body_ref: StaticBody2D
var offset: Vector2
var initialPos: Vector2
var timer: Timer
@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	
	if draggable and not Global.passengerLoading:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position.y = get_global_mouse_position().y - offset.y
		elif Input.is_action_just_released("click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_droppable:
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				print(body_ref.get_node("Label").text)
				Global.currentLevel = body_ref.get_node("Label").text
				if body_ref.get_node("Label").text == str(Global.goalLevel):
					Global.score += 1
					get_parent()._on_timer_timeout()
				checkPassenger()
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
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
	if body_ref.get_node("Passenger") and not Global.passengerInElevator:
		var passenger = body_ref.get_node("Passenger")
		body_ref.remove_child(passenger)
		add_child(passenger)
		passenger.position.x = sprite_2d.position.x - 15
		passenger.position.y = sprite_2d.position.y - 15
		Global.passengerInElevator = true
