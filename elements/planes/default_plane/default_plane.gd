class_name Planes

extends CharacterBody2D

# ########################## #
# Главный класс для самолета #
# ########################## # 

var isPlayer := false

var HEALTH = 1.0 # Прочность
var HEALTH_remains = HEALTH # Остаток прочности 
var mass := 1.0 # Вес самолета для рассчета ускорения
var engine_hp := 1 # Мощность двигателя, лс
var ramDamage = 10 # Урон при таране
var airspeed := 100.0 # текущая скорость
var SPEED = 1 # Максимальная скорость км/ч
var throttle = 0.75 # Текущее значение газа, фактически просто коэффициент скорости
var target_throttle = 0.75 # Положение Ручки Управления Двигателем (дроссель)
const MIN_THROTTLE := 0.65 # Минимальный газ
const MAX_THROTTLE := 1.0  # Максимальный газ
var THROTTLE_CHANGE_SPEED = engine_hp / mass  # Скорость изменения РУД
var SPEED_coef = -3 
var turnRate = 150.0 # Маневренность 
var fireRate = 0.2 
var AMMO = 100
var time_since_last_shot = 0.0
var direction = 0.0
var target_direction := 0.0  # Целевое направление (ввод игрока)
var energy_conservation = 0.05 # Чем больше - тем больше скорости ЛА теряет при маневрах
var energy_loss := 0.0 
var velocity_x := 0.0  # Горизонтальная скорость (для плавности)

var stability := 0.2  # Путевая устойчивость (0-1, где 1 - мгновенная остановка)
var inertia := 0.5  # Инертность поворота (0-1, где 1 - максимальная инерция)

var bullet_scene = preload("res://elements/Bullet/bullet_2d.tscn")
var texture = preload("res://assets/default_plane/plane.png")
var texture_to_left = preload("res://assets/default_plane/plane_to_left.png")
var texture_to_right = preload("res://assets/default_plane/plane_to_right.png")
var boom_effect = preload("res://elements/effects/boom/boom_3/boom_3.tscn")
var flaming_effect = preload("res://elements/effects/flaming_effects/flaming_rocket_fire.tscn")
var smoke_effect1 = preload("res://elements/effects/smoke/smoke1.tscn")
var smoke_effect2 = preload("res://elements/effects/smoke/smoke2.tscn")

var victories := 0

@onready var camera : Camera2D = $Camera2D
var smooth_speed = 5.0
		
func _process(delta: float) -> void:
	# Фиксируем камеру по вертикали (центр экрана)
	camera.position.y = -200 
	

func _physics_process(delta: float) :
	if not isPlayer:             
			velocity.x = target_direction * turnRate
	else:
		# стрельба
		if Input.is_action_pressed("ui_accept"):
			if AMMO > 0:			
				time_since_last_shot += delta
				if time_since_last_shot >= fireRate:
					mg_fire()
					time_since_last_shot = 0.0
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
	energy_loss = abs(velocity_x * energy_conservation) 
	# Обновление спрайта
	if target_direction < -0.2:
		$Sprite2D.texture = texture_to_left
	elif target_direction > 0.2:
		$Sprite2D.texture = texture_to_right
	else:
		$Sprite2D.texture = texture
	
	airspeed = lerp(airspeed, SPEED * throttle - energy_loss, delta) 
	
	var motion = Vector2(velocity_x, airspeed * SPEED_coef) * delta
	var collision = move_and_collide(motion)
	if collision:
		var collider = collision.get_collider()
		if collider and collider.has_method("ram"):
			ram(collider.ramDamage) 
			collider.ram(ramDamage)
	
# Метод для спауна пули
func mg_fire():
	animate_fire()
	AMMO -= 1
	var shell = bullet_scene.instantiate()	
	shell.global_position = global_position + Vector2(0, -60)
	add_child(shell)

	
func animate_fire():
	$Sprite2D/tratata.play("tratata")

func health_check():
	var health_ratio = HEALTH_remains / HEALTH 
	print(health_ratio)
	if health_ratio < 0.6:
		var effect = flaming_effect.instantiate()
		add_child(effect)
	if  health_ratio < 0.5:
		var effect = smoke_effect2.instantiate()
		effect.global_position.y = 35
		effect.z_index = -1
		add_child(effect)
		
# Обработка тарана
func ram(damage):
	HEALTH_remains -= damage
	if HEALTH_remains < 0:
			shot_down()
	else:
		health_check()
		
# Обработка попадания 
func shot(damage, shooter : Planes):
	HEALTH_remains -= damage
	if HEALTH_remains < 0:
		if shooter.isPlayer:
			shot_down_by_player(shooter)
		else:
			shot_down()
	else:
		health_check()

# Обработка сбития
func shot_down():
	var boom = boom_effect.instantiate()
	boom.global_position = position
	add_sibling(boom)
	queue_free()

# Обработка сбития игроком
func shot_down_by_player(shooter: Planes): # Почему то Годо посчитал добавление перегрузки в прошлый метод ошибкой...
	var boom = boom_effect.instantiate()
	boom.global_position = position
	shooter.count_the_victory()
	add_sibling(boom)
	queue_free()

# Выбор случайного направления для уклонения. 
func set_rand_directon():
	target_direction = 	randf_range(-1.0, 1.0)
	
func count_the_victory():
	victories += 1
	
	
