extends Node2D

var isDrawing:bool = true
var lastDrawingMousePos  = Vector2(10000,10000)
var pointsOutOfBounds = 0
const MIN_DRAWING_DIST = 0.5
const RESTART_AMOUNT = 25

var pointScene = preload("res://Scenes/Point.tscn")

var current_letter:Letter
#All letters for the user to draw
var letters = {
	#preload()
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pointsOutOfBounds = 0
	lastDrawingMousePos = Vector2(10000,10000)
	CommunicationTrainingGlobals.letter_finished.connect(next_letter)
	CommunicationTrainingGlobals.add_letter_out.connect(increment_out_of_bound)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mousePos = get_global_mouse_position()
	
	#Check if the mouse has moved enough to require drawing a new point. 
	#Avoids spawning too many entities
	if (mousePos.distance_to(lastDrawingMousePos) > MIN_DRAWING_DIST):
		if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)):
			if (isDrawing):
				lastDrawingMousePos = mousePos
				draw_point(mousePos)
				
	print(pointsOutOfBounds)
				
			
	
func draw_point(mousePos:Vector2) -> void:
	#Spawn in point
	var point:Point = pointScene.instantiate()
	point.global_position = mousePos
	add_child(point)
	
	#Add delay before checking collision
	await get_tree().create_timer(0.1).timeout
	
	#Race condition 
	if (point):
		point.check_collisions()
	
func restart() -> void:
	#Restarts the level if too many points are out
	
	#Lock the user out from drawing
	isDrawing = false
	
	#Let the user start drawing again
	isDrawing = true
	
func next_letter() -> void:
	#Clear the "board", reset variables and get the next letter
	CommunicationTrainingGlobals.clear_points.emit()
	
	#Lock the user out from drawing
	isDrawing = false
	
	#Forced pause to prevent accidental drawing
	await get_tree().create_timer(1).timeout
	
	#Let the user start drawing again
	isDrawing = true
	
	pass
	
func increment_out_of_bound() -> void:
	#Increment the counter counting how many points are out of bounds
	pointsOutOfBounds += 1
