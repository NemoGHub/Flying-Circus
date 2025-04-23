#extends "res://elements/planes/default_plane/default_plane.gd"

class_name Bomber
extends Planes

var player : Planes
var plane : Planes
var isDefending := false


func  _ready() -> void:
	HEALTH = 15
	ramDmage = 10
	SPEED = 140 # максимальная 140
	turnRate = 100.0
	fireRate = 0.12 #  MG08
	AMMO = 700 # Хз сколько 
	plane = get_node(".")
	
	texture = preload("res://assets/GothaGV/GothaGV.png")

	if not get_tree().get_nodes_in_group("Player").is_empty():
		player = get_tree().get_nodes_in_group("Player")[0]

func shot_down():
	set_physics_process(false)
	add_child(boom_effect.instantiate())
	print('Shot down!')
	plane.queue_free()
	#$CollisionShape2D.queue_free()
	#$Sprite2D.queue_free()
	
