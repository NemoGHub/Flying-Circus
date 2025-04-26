class_name Planes

extends CharacterBody2D

var isPlayer := false

var HEALTH = 10
var HEALTH_remains = HEALTH
var ramDamage = 10
var SPEED = 1
var throttle = 0.75
var target_throttle = 0.75
const MIN_THROTTLE := 0.7
const MAX_THROTTLE := 1.2
const THROTTLE_CHANGE_SPEED := 2.0  # Скорость изменения дросселя
var SPEED_coef = 3
var turnRate = 150.0
var fireRate = 0.2
var AMMO = 100
var time_since_last_shot = 0.0
var direction = 0.0
#var current_direction := 0.0  # Текущее фактическое направление (с инерцией)
var target_direction := 0.0  # Целевое направление (ввод игрока)
var velocity_x := 0.0  # Горизонтальная скорость (для плавности)

var stability := 0.2  # Путевая устойчивость (0-1, где 1 - мгновенная остановка)
var inertia := 0.5  # Инертность поворота (0-1, где 1 - максимальная инерция)

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
	
	if HEALTH_remains < 0:
		#fall()
		queue_free()

func _physics_process(delta: float) :
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not isPlayer:             
			velocity.x = target_direction * turnRate
	else:
		if Input.is_action_pressed("ui_accept"):
			if AMMO > 0:			
				time_since_last_shot += delta
				if time_since_last_shot >= fireRate:
					mg_fire()
					time_since_last_shot = 0.0
					print("Fire! MG08 left: " + str(AMMO))		
		#direction = Input.get_axis("ui_left", "ui_right")
		#print(direction)
	 # Получаем ввод игрока
		target_direction = Input.get_axis("ui_left", "ui_right")
		var throttle_input = Input.get_axis("ui_down", "ui_up")
		target_throttle += throttle_input * delta * 0.5  # Меняем множитель для скорости реакции
		# Ограничиваем target_throttle
		target_throttle = clamp(target_throttle, MIN_THROTTLE, MAX_THROTTLE)
		# Плавное изменение текущего throttle к целевому
		throttle = lerp(throttle, target_throttle, THROTTLE_CHANGE_SPEED * delta)
		# Дополнительная "страховка" ограничения (хотя lerp+clamp target уже должны обеспечить)
		throttle = clamp(throttle, MIN_THROTTLE, MAX_THROTTLE)
	
	
	# Плавное изменение направления с инерцией
	direction = lerp(direction, target_direction, stability * delta * 10)
		# Получаем ввод для дросселя (ось "вверх/вниз")
	# Плавное изменение target_throttle с учетом ввода
	# Применяем инерцию к скорости поворота
	velocity_x = lerp(velocity_x, direction * turnRate, (1.0 - inertia) * delta * 10)
		
		# Обновление спрайта
		#update_sprite_direction()
	if target_direction < -0.2:
		$Sprite2D.texture = texture_to_left
	elif target_direction > 0.2:
		$Sprite2D.texture = texture_to_right
	else:
		$Sprite2D.texture = texture
	#velocity.x = direction * turnRate
	#global_position.x = direction * SPEED * delta
	#move_and_slide()
	var motion = Vector2(velocity_x, -SPEED * throttle * SPEED_coef) * delta
	var collision = move_and_collide(motion)
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
	target_direction = 	randf_range(-1.0, 1.0)
	
	
