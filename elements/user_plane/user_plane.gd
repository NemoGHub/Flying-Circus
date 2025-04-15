extends Node2D

const default_plane = preload("res://elements/planes/default_plane/default_plane.tscn")
const FokkerDrI = preload("res://elements/planes/Fokker Dr I/fokkerDrI.tscn")
const  DH2 = preload("res://elements/planes/Airco DH2/airco_dh_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var plane = DH2.instantiate()
	plane.isPlayer = true
	add_child(plane)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setPlayer():
	#print(node.get_index())
	print_tree()

func _on_child_entered_tree(node: Node) -> void:

	if node is Planes:
		node.isPlayer = true
