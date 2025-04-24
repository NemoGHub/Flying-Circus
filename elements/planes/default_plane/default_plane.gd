class_name Planes

extends CharacterBody2D

var isPlayer := false

var HEALTH = 10
var HEALTH_remains = HEALTH
var ramDamage = 10
var SPEED = 1
var SPEED_coef = 3
var turnRate = 150.0
var fireRate = 0.2
var AMMO = 100
var time_since_last_shot = 0.0
var direction = 0.0


var bullet_scene = preload("res://elements/Bullet/bullet_2d.tscn")
var texture = preload("res://assets/default_plane/plane.png")
var texture_to_left = preload("res://assets/default_plane/plane_to_left.png")
var texture_to_right = preload("res://assets/default_plane/plane_to_right.png")
var boom_effect = preload("res://elements/effects/boom/boom_3/boom_3.tscn")

@onready var camera : Camera2D = $Camera2D
var smooth_speed = 5.0

func _ready() -> void:
	pass
		
func _process(delta: float) -> void:
	# Фиксируем камеру по вертикали (центр экрана)
	camera.position.y = -200 
	# Или смещаем относительно игрока (например, на 50 пикселей выше)
	#if camera:
		# Плавное следование по Y (пример)
		#camera.position.y = lerp(camera.position.y, 0.0, 5.0 * delta)
	
	if HEALTH_remains < 0:
		#fall()
		queue_free()

func _physics_process(delta: float) :
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not isPlayer:             
			velocity.x = direction * turnRate
	else:
		if Input.is_action_pressed("ui_accept"):
			if AMMO > 0:			
				time_since_last_shot += delta
				if time_since_last_shot >= fireRate:
					mg_fire()
					time_since_last_shot = 0.0
					print("Fire! MG08 left: " + str(AMMO))		
		direction = Input.get_axis("ui_left", "ui_right")
		#print(direction)
	if direction < -0.2:
		$Sprite2D.texture = texture_to_left
	elif direction > 0.2:
		$Sprite2D.texture = texture_to_right
	else:
		$Sprite2D.texture = texture
	#velocity.x = direction * turnRate
	#global_position.x = direction * SPEED * delta
	#move_and_slide()
	var collision = move_and_collide(Vector2(direction * turnRate, (-1.0 * (SPEED * 0.75) * SPEED_coef)) * delta)
	if collision:
		var collider = collision.get_collider()
		if collider and collider.has_method("shot"):
			print('RAM_EM!' + (str(collider.ramDamage)))
			shot(collider.ramDamage)
			collider.shot(ramDamage)
		

	
	
func mg_fire():
	animate_fire()
	AMMO -= 1
	var shell = bullet_scene.instantiate()	
	shell.global_position = global_position + Vector2(0, -60)
	add_child(shell)

	
func animate_fire():
	$Sprite2D/tratata.play("tratata")
	
func shot(damage):
	
	HEALTH_remains -= damage
	if HEALTH_remains < 0:
		print('Hit')
		shot_down()
		
func shot_down():
	set_physics_process(false)
	add_child(boom_effect.instantiate())
	print('Shot down!')
	$CollisionShape2D.queue_free()
	$Sprite2D.queue_free()
	
func set_rand_directon():
	direction = 	randf_range(-1.0, 1.0)
	
	
