#extends "res://elements/planes/default_plane/default_plane.gd"

class_name Bombers
extends Planes

var player : Planes
var plane : Planes
var isDefending := false
var turret_direction = 0.0
var turretToRight := true

func  _ready() -> void:
	HEALTH = 20
	HEALTH_remains = HEALTH
	ramDamage = 100
	SPEED = 140 # максимальная 140
	turnRate = 100.0
	fireRate = 0.12 #  MG08
	AMMO = 75 # Хз сколько 
	plane = get_node(".")
	
	texture = preload("res://assets/GothaGV/GothaGV.png")
	bullet_scene = preload("res://elements/bullet_turret_default/turret_bullet_default.tscn")
	
	turret_direction = randf_range(-1.0,1.0)
	if randi() % 2:
		turretToRight = false
		texture = preload("res://assets/GothaGV/GothaGV-camo.png")


	if not get_tree().get_nodes_in_group("Player").is_empty():
		player = get_tree().get_nodes_in_group("Player")[0]

func _process(delta: float) -> void:
	if isDefending:
		turret_fire(delta)
	if player:
		#var player_positionX = player.global_position.x
		#print(player_positionX)
		if abs(player.global_position.x - plane.global_position.x) < 200:
			if not isDefending:
				isDefending = true
		elif isDefending:
			isDefending = false
			
func aim_the_turret(): # Unfortunately, gunner is blind.
	if turretToRight and turret_direction < 1.0:
		turret_direction += (turnRate / 1000)
	elif turret_direction > -1.0 :
		turretToRight = false
		turret_direction -= (turnRate / 1000)
	else:
		turretToRight = true
func  turret_fire(delta):
	#set_rand_directon()		
	if AMMO > 0:			
		time_since_last_shot += delta
		if time_since_last_shot >= fireRate:
			aim_the_turret()
			mg_fire()
			time_since_last_shot = 0.0
	
func mg_fire():
	animate_fire()
	AMMO -= 1
	var shell = bullet_scene.instantiate()	
	shell.global_position = global_position + Vector2(0, 130)
	shell.direction = turret_direction 
	add_child(shell)

#func shot_down():
	#set_physics_process(false)
	#add_child(boom_effect.instantiate())
	#print('Shot down!')
	#plane.queue_free()
	##$CollisionShape2D.queue_free()
	##$Sprite2D.queue_free()
	#
