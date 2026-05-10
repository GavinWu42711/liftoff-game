extends Node2D

class_name Confetti

@export var confettiSprite:Sprite2D = Sprite2D.new()

var decaying:bool = false
var decayRate:float = 0.005
var velocity:Vector2 = Vector2(0,0)
var deltaRotation:float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_decay()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (decaying):
		translate(velocity)
		rotate(deltaRotation)
		scale.x -= decayRate
		scale.y -= decayRate
		
		if (scale.x < 0 or scale.y < 0):
			self.queue_free()
	
func start_decay() -> void:
	decaying = true
	

	
