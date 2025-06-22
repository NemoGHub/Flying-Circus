extends Fighter

# #################### #
# Класс для Airco DH.2 #
# #################### # 

func  _ready() -> void:
	HEALTH = 8.0
	HEALTH_remains = HEALTH
	ramDamage = 10
	mass = 680.0
	engine_hp = 110
	SPEED = 150 
	turnRate = 500.0
	energy_conservation = 0.05
	fireRate = 0.1 # 500-600 rounds per minute
	AMMO = 47 * 3
	plane = get_node(".")
	
	texture = preload("res://assets/Airco D.H.2/dh2.png")
	texture_to_left = preload("res://assets/Airco D.H.2/dh2_to_left.png")
	texture_to_right = preload("res://assets/Airco D.H.2/dh2_to_right.png")
	
	if not get_tree().get_nodes_in_group("Player").is_empty():
		player = get_tree().get_nodes_in_group("Player")[0]
