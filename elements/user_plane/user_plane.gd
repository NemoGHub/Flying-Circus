class_name UserPlane
extends Node2D

const default_plane = preload("res://elements/planes/default_plane/default_plane.tscn")
const FokkerDrI = preload("res://elements/planes/Fokker Dr I/fokkerDrI.tscn")
const  DH2 = preload("res://elements/planes/Airco DH2/airco_dh_2.tscn")
const FokkerEI = preload("res://elements/planes/Fokker E I/fokker_EI.tscn")
var planes = [DH2, FokkerDrI, FokkerEI]
var weights = [1, 1, 1]
var player : Planes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var plane = get_plane().instantiate()
	plane.isPlayer = true
	var plane_box = Node2D.new()
	plane_box.add_child(plane)
	plane.add_to_group("Player")
	player = plane
	add_child(plane_box)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !player:
		get_tree().change_scene_to_file("res://Game/main_menu/main_menu.tscn")
	 #Обновляем UI при изменении значений
	else:
		$"../UI_parameters".update_display(player.airspeed, player.AMMO, player.HEALTH_remains, player.victories)

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
