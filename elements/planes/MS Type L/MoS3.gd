extends Fighter

func  _ready() -> void:
	HEALTH = 4
	HEALTH_remains = HEALTH
	ramDamage = 6
	mass = 393
	engine_hp = 80
	SPEED = 125 
	turnRate = 330.0 # Меньше чем у айндекера ибо тип L высокоплан-парасоль, а фоккер - низкоплан
	energy_conservation = 0.02
	fireRate = 0.1 # 500-600 rounds per minute
	AMMO = 0
	plane = get_node(".")
	
	texture = preload("res://assets/MS Type L/MoS3.png")
	texture_to_left = preload("res://assets/MS Type L/MoS3_to_left.png")
	texture_to_right = preload("res://assets/MS Type L/MoS3_to_right.png")
	#var smoke_scene = preload("res://elements/effects/smoke.tscn")
	
	if not get_tree().get_nodes_in_group("Player").is_empty():
		player = get_tree().get_nodes_in_group("Player")[0]
