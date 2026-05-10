extends Button
class_name ButtonClass
static var button_list:Array[Button]
static var button_count:int = 0
var button_num:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_num = button_count
	button_count+=1
	print(button_count)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _pressed() -> void:
	#self.visible = false
	print(self.button_num)
	if self.button_num == Global.clicked:
		Global.clicked+=1
		print(Global.clicked)
		if Global.stage == Global.clicked:
			Global.stage_complete = true
	else: 
		print("youre a chud")
