extends Node2D

class_name Point

var area2D:Area2D 
var letterArea:Area2D
@onready var line2D:Line2D = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area2D = $Area2D
	
	#Points can only see areas on layer 8
	area2D.set_collision_mask_value(8,true)
	area2D.set_collision_mask_value(1,false)
	
	#Points can only be detected on layer 2
	area2D.set_collision_layer_value(2, true)
	area2D.set_collision_layer_value(1, false)
	
	#Connect to global signal
	CommunicationTrainingGlobals.clear_points.connect(clear)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
func turn_valid_colour() -> void:
	#Valid sprite
	line2D.default_color = Color(255,255,255)
	
func turn_invalid_colour() -> void:
	#Invalid sprite
	line2D.default_color = Color(255,0,0)

func check_collisions() -> void:
	if area2D.get_overlapping_areas():
		turn_valid_colour()
	else:
		turn_invalid_colour()
		CommunicationTrainingGlobals.add_letter_out.emit()
	
#Dequeue's points when a level is restarting, moving on, e.t.c		
func clear() -> void:
	self.queue_free()
	

	
	
