extends Camera2D

@export var max_offset := Vector2(110, 100)  # Макс. смещение при манёврах
@export var lag_speed := 0.35  # Скорость "подхвата" камеры (чем меньше — тем плавнее)


var target_offset := Vector2(0,-200)
var current_offset := Vector2(0,-100)

func _physics_process(delta: float):
	# Получаем направление манёвра (например, из velocity или input)
	var maneuver_direction = Input.get_axis("ui_left", "ui_right")
	
	# Рассчитываем целевое смещение (чем резче поворот — тем сильнее смещение)
	target_offset.x = max_offset.x * maneuver_direction
	
	# Плавное приближение к целевому смещению
	current_offset = current_offset.lerp(target_offset, lag_speed * delta)
	
	# Применяем смещение (в локальных координатах камеры)
	position = current_offset
