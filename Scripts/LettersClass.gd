extends Node2D

class_name Letter

#Area 2D that recognizes how much of the points landed in the letter
@export var letterSections:Array[Area2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Make sure all letter sections have the right mask
	if (letterSections):
		for letterSection:Area2D in letterSections:
			#Can only be detected on layer 8
			letterSection.set_collision_layer_value(1,false)
			letterSection.set_collision_layer_value(8, true)
			#Can only detect on layer 2 
			letterSection.set_collision_mask_value(1, false)
			letterSection.set_collision_mask_value(2,true)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_sections()
	
#Check if all area2D sections of the letter contain a point in them
func check_sections() -> void:
	#Boolean flag for if all sections have atleast 1 point in them
	var letter_completed:bool = true
	
	#Make sure letter sections is not null
	if (letterSections):
		for letterSection:Area2D in letterSections:
			if not letterSection.get_overlapping_areas():
				letter_completed = false
				
		#Decision based on if letter is completed
		if (letter_completed):
			CommunicationTrainingGlobals.letter_finished.emit()
				
		
