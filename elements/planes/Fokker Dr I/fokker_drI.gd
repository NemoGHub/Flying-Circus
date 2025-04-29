class_name Fighter
extends Planes

var player : Planes
var plane : Planes
var isEvading := false

func  _ready() -> void:
	HEALTH = 10.0
	HEALTH_remains = HEALTH
	ramDamage = 10
	mass = 406.0
	engine_hp = 110
	SPEED = 185 #r крейсерская 140; максимальная 185
	turnRate = 600.0
	energy_conservation = 0.1
	fireRate = 0.12 * 0.5 # 2 * MG08
	AMMO = 250 * 2
	plane = get_node(".")
	
	texture = preload("res://assets/FokkerDrI/fokker_dr1.png")
	texture_to_left = preload("res://assets/FokkerDrI/fokker_dr1_to_left.png")
	texture_to_right = preload("res://assets/FokkerDrI/fokker_dr1_to_right.png")
	
	
	if not get_tree().get_nodes_in_group("Player").is_empty():
		player = get_tree().get_nodes_in_group("Player")[0]
		
		
func _process(delta: float) -> void:
	#health_check()
	if (not isPlayer) and player:
		#var player_positionX = player.global_position.x
		#print(player_positionX)
		if abs(player.global_position.x - plane.global_position.x) < 100:
			if not isEvading:
				isEvading = true
				evasive_manuever()
		elif isEvading:
			stop_evasion()
func  evasive_manuever():
	set_rand_directon()
	target_throttle = 1.0
	$Timer_evading.wait_time = randf_range(0.5, 2.0)
	$Timer_evading.start()
	
func speed_up():
	pass
	
func stop_evasion():
	direction = 0.0
	target_throttle = 0.75
	isEvading = false

#func shot_down():
	#set_physics_process(false)
	#print('Shot down!')
	#plane.add_sibling(boom_effect.instantiate())
	##plane.queue_free()
	##$CollisionPolygon2D.queue_free()
	##$Sprite2D.queue_free()

func _on_timer_evading_timeout() -> void:
	evasive_manuever()
