extends Node2D
var og_sprite_list:Array[Sprite2D]
var shuff_sprite_list:Array[Sprite2D]
var binary_list:Array[int]
@onready var salad: Sprite2D = $Salad
@onready var battery: Sprite2D = $Battery
@onready var right: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var wrong: AudioStreamPlayer2D = $AudioStreamPlayer2D2

@onready var celebrationScene = $CelebrationScene
@onready var happybutton: Button = $happybutton
@onready var sadbutton: Button = $sadbutton
@onready var toast: Sprite2D = $toast
@onready var marble: Sprite2D = $marble
@onready var oj: Sprite2D = $oj

var isFinished:bool = false
var checkFinished:bool = false

var current = 0
var score = 0
var max_score = 5
var answered = false
signal next

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isFinished = false
	og_sprite_list = [salad, battery, oj, marble, toast]
	shuff_sprite_list = [salad, battery, oj, marble, toast]
	#1 = good, 0 = bad
	binary_list = [1, 0, 1, 0 , 1]
	shuff_sprite_list.shuffle()
	run()

func run():
	for i in range(shuff_sprite_list.size()):
		current = i
		shuff_sprite_list[i].visible = true
		answered = false
		print(answered)
		await next
		print("asdfasdfasdf")
	
	checkFinished = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (checkFinished):
		if score == max_score and not isFinished:
			isFinished = true
			celebrationScene.activate()
			await get_tree().create_timer(4).timeout
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
		elif not isFinished:
			isFinished = true
			wrong.play()
			await get_tree().create_timer(2.5).timeout
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_happybutton_pressed() -> void:
	print(answered)
	if not answered:
		for i in range(og_sprite_list.size()):
			if shuff_sprite_list[current] == og_sprite_list[i]:
				if binary_list[i] == 1:
					score += 1
					right.play()
					break
				else:
					wrong.play(2)
					break
		shuff_sprite_list[current].visible = false
		print("emitting")
		answered = true
		next.emit()
		

func _on_sadbutton_pressed() -> void:
	print(answered)
	if not answered:
		for i in range(og_sprite_list.size()):
			if shuff_sprite_list[current] == og_sprite_list[i]:
				if binary_list[i] == 0:
					score += 1
					right.play()
					break
				else:
					wrong.play(2)
					break
		shuff_sprite_list[current].visible = false
		print("emitting")
		answered = true
		next.emit()
		
