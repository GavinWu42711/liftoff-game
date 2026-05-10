extends Node2D

@onready var motorButton:Button = $Motor
@onready var communicationButton:Button = $Communication
@onready var socialButton:Button = $Social

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	communicationButton.pressed.connect(changeToComScene)
	motorButton.pressed.connect(changeToMotorScene)


# Cal	led every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func changeToComScene() -> void:
	get_tree().change_scene_to_file("res://Scenes/CommunicationTraining.tscn")
	
func changeToMotorScene() -> void:
	get_tree().change_scene_to_file("res://Scenes/MotorTraining.tscn")
