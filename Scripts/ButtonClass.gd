extends Button
class_name ButtonClass
static var button_list:Array[Button]
static var button_count:int = 0
var button_num:int
var clicked = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_num = button_count
	button_count+=1
	print(button_count)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _pressed() -> void:
	self.visible = false
	if self.button_num == clicked:
		clicked+=1
	else:
		pass #place lose code here or something idk
