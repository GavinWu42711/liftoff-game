extends Node2D

var poppers:Array 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	poppers = [$ConfettiPopper,
	$ConfettiPopper2,
	$ConfettiPopper3,
	$ConfettiPopper4]
	
	for popper:Node2D in poppers:
		popper.visible = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func activate() -> void:
	for popper:ConfettiPopper in poppers:
		popper.visible = true
		popper.activate()
