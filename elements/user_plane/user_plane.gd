extends Node2D

const default_plane = preload("res://elements/planes/default_plane/default_plane.tscn")
const FokkerDrI = preload("res://elements/planes/Fokker Dr I/fokkerDrI.tscn")
const  DH2 = preload("res://elements/planes/Airco DH2/airco_dh_2.tscn")
var planes = [DH2, FokkerDrI]
var weights = [1, 1]
var player : Planes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var plane = get_plane().instantiate()
	plane.isPlayer = true
	add_child(plane)
	plane.add_to_group("Player")
	player = plane

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Обновляем UI при изменении значений
	$"../UI_parameters".update_display(player.airspeed, player.AMMO, player.HEALTH_remains)

func setPlayer():
	#print(node.get_index())
	print_tree()

func _on_child_entered_tree(node: Node) -> void:
	if node is Planes:
		node.isPlayer = true
		
func get_plane():
	var rng = RandomNumberGenerator.new() 
	var enemy_plane = planes[rng.rand_weighted(weights)]
	return enemy_plane
