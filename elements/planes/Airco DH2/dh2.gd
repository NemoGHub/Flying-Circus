extends Planes

func  _ready() -> void:
	HEALTH = 3
	ramDmage = 10
	SPEED = 150 * 0.75
	turnRate = 250.0
	fireRate = 0.1 # 500-600 rounds per minute
	AMMO = 47 * 3
	
	texture = preload("res://assets/Airco D.H.2/dh2.png")
	texture_to_left = preload("res://assets/Airco D.H.2/dh2_to_left.png")
	texture_to_right = preload("res://assets/Airco D.H.2/dh2_to_right.png")
	#var smoke_scene = preload("res://elements/effects/smoke.tscn")
	
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
