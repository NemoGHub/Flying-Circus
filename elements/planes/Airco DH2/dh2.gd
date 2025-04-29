extends Fighter

func  _ready() -> void:
	HEALTH = 3
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
	#var smoke_scene = preload("res://elements/effects/smoke.tscn")
	
	if not get_tree().get_nodes_in_group("Player").is_empty():
		player = get_tree().get_nodes_in_group("Player")[0]
	
#func shot_down():
	#set_physics_process(false)
	#add_child(boom_effect.instantiate())
	#print('Shot down!')
	##$CollisionShape2D.queue_free()
	##$CollisionPolygon2D.queue_free()
 	#$"Sprite2D".queue_free()
