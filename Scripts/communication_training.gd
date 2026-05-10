extends Node2D

var isDrawing:bool = true
var lastDrawingMousePos  = Vector2(10000,10000)
var pointsOutOfBounds = 0
const MIN_DRAWING_DIST = 0.5
const RESTART_AMOUNT = 5

#Scene for the points that are drawn onto the screen
var pointScene = preload("res://Scenes/Point.tscn")

@onready var wrongAnswerSound:AudioStreamPlayer2D = $AudioStreamPlayer2D2

#Array containing all letter scenes
var letterScenes = [preload("res://Scenes/LetterA.tscn"),
preload("res://Scenes/LetterB.tscn"),
preload("res://Scenes/LetterC.tscn"),
preload("res://Scenes/LetterD.tscn"),
preload("res://Scenes/LetterE.tscn"),
preload("res://Scenes/LetterF.tscn"),
preload("res://Scenes/LetterG.tscn"),
preload("res://Scenes/LetterH.tscn"),
preload("res://Scenes/LetterI.tscn"),
preload("res://Scenes/LetterJ.tscn"),
preload("res://Scenes/LetterK.tscn"),
preload("res://Scenes/LetterL.tscn"),
preload("res://Scenes/LetterM.tscn"),
preload("res://Scenes/LetterN.tscn"),
preload("res://Scenes/LetterO.tscn"),
preload("res://Scenes/LetterP.tscn"),
preload("res://Scenes/LetterQ.tscn"),
preload("res://Scenes/LetterR.tscn"),
preload("res://Scenes/LetterS.tscn"),
preload("res://Scenes/LetterT.tscn"),
preload("res://Scenes/LetterU.tscn"),
preload("res://Scenes/LetterV.tscn"),
preload("res://Scenes/LetterW.tscn"),
preload("res://Scenes/LetterX.tscn"),
preload("res://Scenes/LetterY.tscn"),
preload("res://Scenes/LetterZ.tscn")
]
	
#Enum to convert alphabet letter to index
enum alphabetEnum {A,B,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z}
	
var current_letter:Letter
var current_letter_index:int

@onready var celebrationScene = $CelebrationScene
@onready var blankBackgroundSprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pointsOutOfBounds = 0
	
	#Let the user start drawing from anywhere
	lastDrawingMousePos = Vector2(10000,10000)
	
	CommunicationTrainingGlobals.letter_finished.connect(next_letter)
	CommunicationTrainingGlobals.add_letter_out.connect(increment_out_of_bound)
	
	
	current_letter = letterScenes[alphabetEnum.A].instantiate()
	current_letter_index = alphabetEnum.A
	add_child(current_letter)

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
				
	if pointsOutOfBounds >= RESTART_AMOUNT:
		restart()
				
func draw_point(mousePos:Vector2) -> void:
	#Spawn in point
	var point:Point = pointScene.instantiate()
	point.global_position = mousePos
	add_child(point)
	
	#Add delay before checking collision; wait 1 physics frame
	await get_tree().create_timer(0.07).timeout
	
	#Race condition 
	if (point):
		point.check_collisions()
	
func restart() -> void:
	#Restarts the level if too many points are out
	
	#Clear the "board"
	CommunicationTrainingGlobals.clear_points.emit()
	
	#Lock the user out from drawing
	isDrawing = false
	
	#Let the user start drawing from anywhere
	lastDrawingMousePos = Vector2(10000,10000)
	
	#Reset out of bounds counter
	pointsOutOfBounds = 0
		
	#wrong answer sound
	wrongAnswerSound.play(1)
		
	blankBackgroundSprite.fade_in()
	
	await get_tree().create_timer(1).timeout
	
	
	
	#Forced pause to prevent accidental drawing
	await get_tree().create_timer(0.1).timeout
	
	blankBackgroundSprite.fade_out()
	
	await get_tree().create_timer(1).timeout
	
	
	#Let the user start drawing again
	isDrawing = true
	
func next_letter() -> void:
	#Clear the "board", reset variables and get the next letter
	CommunicationTrainingGlobals.clear_points.emit()
	
	#Lock the user out from drawing
	isDrawing = false
	
	#Reset out of bounds counter
	pointsOutOfBounds = 0
	
	#Let the user start drawing from anywhere
	lastDrawingMousePos = Vector2(10000,10000)
	
	#Go to the next letter in the alphabet
	if current_letter_index < 25:
		current_letter_index+= 1
		
		blankBackgroundSprite.fade_in()
	
		celebrationScene.activate()
		
		#Forced pause to prevent accidental drawing
		await get_tree().create_timer(3.5).timeout
		
		CommunicationTrainingGlobals.clear_letter.emit()
		#Instantiate the new letter
		current_letter = letterScenes[current_letter_index].instantiate()
		add_child(current_letter)
		
		blankBackgroundSprite.fade_out()
		
		#Let the user start drawing again
		isDrawing = true
	else:
		current_letter_index = 0
		
		blankBackgroundSprite.fade_in()
	
		celebrationScene.activate()
		
		#Forced pause to prevent accidental drawing
		await get_tree().create_timer(3.5).timeout
		
		CommunicationTrainingGlobals.clear_letter.emit()
		
		#Let the user start drawing again
		isDrawing = true
		
		await get_tree().create_timer(0.5).timeout
		
		#Switch scene
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
		
		
	
	
func increment_out_of_bound() -> void:
	#Increment the counter counting how many points are out of bounds
	pointsOutOfBounds += 1

func finish() -> void:
	#Ends the activity and goes back to the main menu
	pass

	
