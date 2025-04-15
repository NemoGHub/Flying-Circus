extends Node2D

var SPEED = 500
func _ready() -> void:
	$tratata.play()
	
func  _physics_process(delta: float) -> void:
	move_local_y(delta * SPEED)
