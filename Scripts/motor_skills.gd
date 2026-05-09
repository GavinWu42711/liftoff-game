extends Node

var button1:Button
var button2:Button
var button3:Button
var button4:Button
var button5:Button
var button6:Button
var button7:Button
var button8:Button
var button9:Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button1 = $Button1
	button2 = $Button2
	button3 = $Button3
	button4 = $Button4
	button5 = $Button5
	button6 = $Button6
	button7 = $Button7
	button8 = $Button8
	button9 = $Button9
	
	pass # Replace with function body.
	#connect buttons to input
	button1.button_down.connect(button_1_pressed)
	button2.button_down.connect(button_2_pressed)
	button3.button_down.connect(button_3_pressed)
	button4.button_down.connect(button_4_pressed)
	button5.button_down.connect(button_5_pressed)
	button6.button_down.connect(button_6_pressed)
	button7.button_down.connect(button_7_pressed)
	button8.button_down.connect(button_8_pressed)
	button9.button_down.connect(button_9_pressed)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	
	
	pass
	
func button_1_pressed() -> void:
	button1.visible = false
	#put code to move the position of the button somewhere else on the screen to avoid showing user the planet again
	pass
func button_2_pressed() -> void:
	button2.visible = false
	pass
func button_3_pressed() -> void:
	button3.visible = false
	pass	
func button_4_pressed() -> void:
	button4.visible = false
	pass
func button_5_pressed() -> void:
	button5.visible = false
	pass
func button_6_pressed() -> void:
	button6.visible = false
	pass
func button_7_pressed() -> void:
	button7.visible = false
	pass
func button_8_pressed() -> void:
	button8.visible = false
	pass
func button_9_pressed() -> void:
	button9.visible = false
	pass
