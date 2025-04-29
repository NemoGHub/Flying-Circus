extends Bombers

func  _ready() -> void:
	HEALTH = 15
	HEALTH_remains = HEALTH
	ramDamage = 50
	SPEED = 177 # максимальная 177
	turnRate = 200.0
	#fireRate = 60/550 #  Lewis firerate is equals to MG08
	AMMO = 120 * 2 # Хз сколько 
	plane = get_node(".")
	
	texture = preload("res://assets/Breguet XIV/Breguet_xiv.png")
	bullet_scene = preload("res://elements/bullet_turret_default/turret_bullet_default.tscn")
	
	turret_direction = randf_range(-1.0,1.0) 

	if not get_tree().get_nodes_in_group("Player").is_empty():
		player = get_tree().get_nodes_in_group("Player")[0]
