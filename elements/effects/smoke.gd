extends Node2D

var SPEED = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y > 850:
		queue_free()
	move_local_y(1 * SPEED * delta)
