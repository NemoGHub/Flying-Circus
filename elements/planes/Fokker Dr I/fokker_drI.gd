class_name Fighter
extends Planes

var player : Planes
var plane : Planes
var isEvading := false

func  _ready() -> void:
	HEALTH = 5
	ramDmage = 10
	SPEED = 185 #r крейсерская 140; максимальная 185
	turnRate = 300.0
	fireRate = 0.12 * 0.5 # 2 * MG08
	AMMO = 600 # Хз сколько 
	plane = get_node(".")
	
	texture = preload("res://assets/FokkerDrI/fokker_dr1.png")
	texture_to_left = preload("res://assets/FokkerDrI/fokker_dr1_to_left.png")
	texture_to_right = preload("res://assets/FokkerDrI/fokker_dr1_to_right.png")
	
	
	if not get_tree().get_nodes_in_group("Player").is_empty():
		player = get_tree().get_nodes_in_group("Player")[0]
		
		
func _process(delta: float) -> void:
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
	$Timer_evading.wait_time = randf_range(0.5, 2.0)
	$Timer_evading.start()
	
func stop_evasion():
	direction = 0.0
	isEvading = false
	
func set_rand_directon():
	direction = 	randf_range(-1.0, 1.0)


func _on_timer_evading_timeout() -> void:
	print("timer")
	evasive_manuever()
