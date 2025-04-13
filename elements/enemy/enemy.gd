extends Node2D

var enemy_plane = preload("res://elements/enemy_plane/enemy_plane.tscn")
var spawn_rate = 3
var spawn_area_width = 1000.0
var screen_width: float

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
	print('Timeout!')
	spawn_enemy()
	
func spawn_enemy():
	if !enemy_plane:
		return
	
	# Создаём врага
	var enemy = enemy_plane.instantiate()
	add_child(enemy)
	
	# Позиция спавна: случайная X за верхней границей экрана
	var spawn_x = randf_range(40, spawn_area_width)
	enemy.global_position = Vector2(spawn_x, -50)  # -50 выше экрана
