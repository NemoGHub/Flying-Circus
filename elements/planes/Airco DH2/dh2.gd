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
	
func shot_down():
	set_physics_process(false)
	add_child(boom_effect.instantiate())
	print('Shot down!')
	$CollisionShape2D.queue_free()
	#$CollisionPolygon2D.queue_free()
	$Sprite2D.queue_free()
	
#func mg_fire():
	#var shell = bullet_scene.instantiate()	
	#shell.global_position = global_position + Vector2(-2, -40)
	#add_child(shell)
	#
#func shot(damage):
	#HEALTH_remains -= damage
	#if HEALTH_remains < 0:
		#print('Hit')
		#shot_down()
		#
#func shot_down():
	#print('Shot down!')
	#direction = randf_range(-1.0, 1.0)
	#$Timer.wait_time = randf_range(0.0, 10.0)
	#$Timer.start()
	#
#func fall():
	##var smoke = smoke_scene.instantiate()
	##add_child(smoke) 
	#if direction > 0.0:
		#$Sprite2D.texture = texture_to_right
	#elif direction < 0.0:
		#$Sprite2D.texture = texture_to_left
	#else:
		#$Sprite2D.texture = texture
	#if $Sprite2D.scale < Vector2(0.5, 0.5):
		#queue_free()
	#$Sprite2D.scale -= Vector2(0.005, 0.005)
	#velocity.x = direction * turnRate
	#velocity.y *= 1.5
	#move_and_slide()
#
#
#func _on_timer_timeout() -> void:
	#queue_free()
