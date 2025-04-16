extends Node2D

var default_plane = preload("res://elements/enemy_plane/enemy_plane.tscn")
var AircoDH2 = preload("res://elements/planes/Airco DH2/airco_dh_2.tscn")
var FokkerDrI = preload("res://elements/planes/Fokker Dr I/fokkerDrI.tscn")
var planes  = [default_plane, AircoDH2, FokkerDrI]
var Entente = [AircoDH2]
var CentralEmpires = [FokkerDrI]
var weights = [1, 1, 1]

var screen_width: float

var player : Planes
var spawn_distance = 1000
var spawn_arc_degrees = 90.0
var spawn_rate = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	# Запускаем таймер спавна
	$Timer.wait_time = spawn_rate
	$Timer.start()	
		
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout():
	player = get_tree().get_nodes_in_group("Player")[0]
	if player:
		if player.is_in_group("Entente"):
			weights = [1, 2, 5]
		elif player.is_in_group("CentralEmpires"):
			weights = [1, 5, 2]
		print('Another bandit!')
		spawn_enemy(player)
		
#func spawn_enemy_old():
	#var rng = RandomNumberGenerator.new()
	#var enemy_plane = planes[rng.rand_weighted(weights)]
	#if !enemy_plane:
		#return
	#
	## Создаём врага
	#var enemy = enemy_plane.instantiate()
	#add_child(enemy)
	#
	## Позиция спавна: случайная X за верхней границей экрана
	#var spawn_x = randf_range(40, spawn_area_width)
	#enemy.global_position = Vector2(spawn_x, -50)  # -50 выше экрана
	
func spawn_enemy(player: Node2D):
	
	# 1. Получаем направление игрока вперёд
	var player_forward = Vector2.UP.rotated(player.rotation)
	# 2. Выбираем случайный угол в пределах полусферы
	var random_angle = deg_to_rad(
		randf_range(-spawn_arc_degrees/2, spawn_arc_degrees/2)
	)
	var spawn_direction = player_forward.rotated(random_angle)
	
	# 3. Вычисляем позицию спауна
	var spawn_position = player.global_position + spawn_direction * spawn_distance
		# Создаём врага
	var enemy_plane= get_enemy().instantiate()
	add_child(enemy_plane)
	enemy_plane.global_position = spawn_position
	
func get_enemy():
	var rng = RandomNumberGenerator.new() 
	var enemy_plane = planes[rng.rand_weighted(weights)]
	return enemy_plane
