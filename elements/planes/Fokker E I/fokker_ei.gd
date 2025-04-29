extends Fighter

func  _ready() -> void:
	HEALTH = 3
	ramDamage = 10
	mass = 357.0
	engine_hp = 80
	SPEED = 132 
	turnRate = 350.0
	energy_conservation = 0.02
	fireRate = 0.1 # 500-600 rounds per minute
	AMMO = 250
	plane = get_node(".")
	
	texture = preload("res://assets/FokkerEI/FokkerEI.png")
	texture_to_left = preload("res://assets/FokkerEI/FokkerEI_to_left.png")
	texture_to_right = preload("res://assets/FokkerEI/FokkerEI_to_right.png")
	#var smoke_scene = preload("res://elements/effects/smoke.tscn")
	
	if not get_tree().get_nodes_in_group("Player").is_empty():
		player = get_tree().get_nodes_in_group("Player")[0]
	
func shot_down():
	set_physics_process(false)
	add_child(boom_effect.instantiate())
	print('Shot down!')
	$CollisionShape2D.queue_free()
	#$CollisionPolygon2D.queue_free()
	#$CollisionPolygon2D.queue_free()
	$Sprite2D.queue_free()
	#queue_free()
