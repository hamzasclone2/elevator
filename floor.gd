extends StaticBody2D

@export var floorLevel: String = '0'
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)
	label.text = floorLevel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.is_dragging:
		visible = true
	else:
		visible = false
