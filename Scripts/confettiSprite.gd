extends Sprite2D

@onready var animationPlayer:AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func fade_in():
	animationPlayer.play("fade_in")

func fade_out():
	animationPlayer.play("fade_out")

	
