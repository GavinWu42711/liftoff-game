extends Node2D
class_name game
signal move
@onready var button_1: Button = $Button1
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
@onready var button_4: Button = $Button4
@onready var button_5: Button = $Button5
@onready var button_6: Button = $Button6
@onready var button_7: Button = $Button7
@onready var button_8: Button = $Button8
@onready var button_9: Button = $Button9
@onready var marker_2d: Marker2D = $Marker2D
@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d_3: Marker2D = $Marker2D3
@onready var marker_2d_4: Marker2D = $Marker2D4
@onready var marker_2d_5: Marker2D = $Marker2D5
@onready var marker_2d_7: Marker2D = $Marker2D7
@onready var marker_2d_8: Marker2D = $Marker2D8
@onready var marker_2d_9: Marker2D = $Marker2D9
@onready var marker_2d_6: Marker2D = $Marker2D6

var stage_complete = false
var stage_counter:int = 0
var marker_list:Array[Marker2D]
var button_list:Array[Button]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("run")
func run():
	Global.button_list = [button_1, button_2, button_3, button_4, button_5, button_6, button_7, button_8, button_9] as Array[Button]
	button_list = [button_1, button_2, button_3, button_4, button_5, button_6, button_7, button_8, button_9] as Array[Button]
	marker_list = [marker_2d, marker_2d_2, marker_2d_3, marker_2d_4, marker_2d_5, marker_2d_6, marker_2d_7, marker_2d_8, marker_2d_9] as Array[Marker2D]
	#spawning in the buttons for the game using for loop
	Global.button_list.shuffle()
	for i in range(ButtonClass.button_count):
		Global.button_list[i].global_position = marker_list[i].global_position
		print("moved")
		Global.button_list[i].visible = true
		#calling in each button path then incrementing to toggle visiblity		
		await get_tree().create_timer(0.3).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#checks if the stage is completed then increments how many buttons should be visible
	#then we toggle visibility on the buttons that should be visible from the counter
	if stage_complete == true:
		stage_complete = false
		stage_counter += 1
	for i in range(stage_counter):
		if i in range(i < 9):
			toggle_visiblity(i)
	pass

#toggle visiblity function
func toggle_visiblity(index:int) -> void:
	if Global.button_list[index].visible:
		Global.button_list[index].visible = false
	else:
		Global.button_list[index].visible = true
