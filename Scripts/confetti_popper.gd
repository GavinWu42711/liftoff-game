extends Node2D

class_name ConfettiPopper

@export var popperSprite:Sprite2D = Sprite2D.new()

var confettiScenes:Array[Resource] = [preload("res://Scenes/BlueConfetti.tscn"),
preload("res://Scenes/PinkConfetti.tscn"),
preload("res://Scenes/RedConfetti.tscn"),
preload("res://Scenes/YellowConfetti.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#Shoots 50 confetties in random directions	
func shoot() -> void:
	for i in range(50):
		var confetti:Confetti = confettiScenes[randi_range(0,3)].instantiate()
		confetti.deltaRotation = randf_range(0,0.2)
		confetti.velocity = Vector2(randf_range(5,10),randf_range(-3,3))
		add_child(confetti)
		confetti.start_decay()

func fade_in() -> void:
	popperSprite.fade_in()
	
func fade_out() -> void:
	popperSprite.fade_out()
	
func activate() -> void:
	fade_in()
	await get_tree().create_timer(2).timeout
	shoot()
	await get_tree().create_timer(1).timeout
	fade_out()
	
