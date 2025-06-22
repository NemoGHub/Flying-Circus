extends Node2D

# ######################################### #
# Класс, ответственный за спаун противников #
# ######################################### #

# Подгрузка самолетов-врагов
var default_plane = preload("res://elements/planes/default_plane/default_plane.tscn")
var AircoDH2 = preload("res://elements/planes/Airco DH2/airco_dh_2.tscn")
var MoS3 = preload("res://elements/planes/MS Type L/MoS3.tscn")
var FokkerEI = preload("res://elements/planes/Fokker E I/fokker_EI.tscn")
var FokkerDrI = preload("res://elements/planes/Fokker Dr I/fokkerDrI.tscn")
var GothaGV = preload("res://elements/planes/Gotha GV/gotha_gv.tscn")
var BreguetXIV = preload("res://elements/planes/Breguet XIV/breguet_xiv.tscn")
# Список всех самолетов
var planes  = [default_plane, 
	MoS3,
	AircoDH2, 
	FokkerEI, 
	FokkerDrI, 
	GothaGV, 
	BreguetXIV]
# Стандартные веса, определяющие вероятность спауна самолета, если не заданы специално 
var weights = [0, 2, 3, 2, 3, 1, 1] 

# Переменные, описывающие принадлежность самолетов 
var Entente = [MoS3, AircoDH2, BreguetXIV] # Самолеты Антанты
var CentralEmpires = [FokkerEI, FokkerDrI, GothaGV] # Самолеты Центральных держав

var screen_width: float

var player : Planes
var spawn_distance = 1000
var spawn_arc_degrees = 90.0 # Определяет область в градусах, где будут спауниться самолеты спереди игрока
var spawn_rate = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	# Запускаем таймер спавна
	$Timer.wait_time = spawn_rate
	$Timer.start()	


func _on_timer_timeout():
	player = get_tree().get_nodes_in_group("Player")[0]
	if player:
		spawn_enemy(player)
	
func spawn_enemy(player):
	# Получаем направление игрока вперёд
	var player_forward = Vector2.UP.rotated(player.rotation)
	# Выбираем случайный угол в пределах полусферы
	var random_angle = deg_to_rad(
		randf_range(-spawn_arc_degrees/2, spawn_arc_degrees/2)
	)
	var spawn_direction = player_forward.rotated(random_angle)
	
	# Вычисляем позицию спауна
	var spawn_position = player.global_position + spawn_direction * spawn_distance
	# Создаём врага
	var enemy_plane= get_enemy().instantiate()
	# Кладем его в коробочку-обертку
	var enemy_box = Node2D.new()
	enemy_box.add_child(enemy_plane)
	# И вставляем в дерево
	add_child(enemy_box)
	enemy_plane.global_position = spawn_position
	
func get_enemy():
	var rng = RandomNumberGenerator.new() 
	var enemy_plane = planes[rng.rand_weighted(weights)]
	return enemy_plane
