extends ButtonClass
class_name game
@onready var button_1: Button = $Button1
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
@onready var button_4: Button = $Button4
@onready var button_5: Button = $Button5
@onready var button_6: Button = $Button6
@onready var button_7: Button = $Button7
@onready var button_8: Button = $Button8
@onready var button_9: Button = $Button9
var button_list:= [button_1, button_2, button_3, button_4, button_5, button_6, button_7, button_8, button_9] as Array[Button]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func run():
	#spawning in the buttons for the game using for loop
	for i in (button_count):
		#calling in each button path then incrementing to toggle visiblity
		button_list[i].visible = true
		button_list[i].global_position = Vector2(randf_range(247.0,798.0),randf_range(261.0 ,628.0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
