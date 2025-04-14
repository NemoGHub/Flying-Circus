extends Node2D

const FokkerDrI = preload("res://elements/FokkerDrI/FokkerDrI.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var plane = FokkerDrI.instantiate()	
	add_child(plane)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
