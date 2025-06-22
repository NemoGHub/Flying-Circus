class_name Bullet
extends CharacterBody2D

# The bullet is spawned by plane and hits a collider. 

const SPEED = 800.0 * 2
const DAMAGE = 1
var direction = 0.0
var collision_effect =preload("res://elements/effects/boom/boom_1/boom_1.tscn")


func _ready():
	# Проверка загрузки текстуры
	if $Sprite2D.texture == null:
		print("Ошибка: текстура пули не назначена!")

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(Vector2.UP * SPEED * delta)
	if collision:
		hit(delta, collision)

			
func hit(delta: float, collision):
		set_physics_process(false) # прекращаем симуляцию
		add_child(collision_effect.instantiate()) # Создаем эффект попадания
		var collider = collision.get_collider() #Получения цели
		if collider and collider.has_method("shot"): 
			print('Попадание')
			collider.shot(DAMAGE, get_parent()) # Вызываем у цели метод попадания
		$CollisionShape2D.queue_free() # Удаляем
		$Sprite2D.queue_free()
		move_local_y(delta * 100) # Перемещение эффекта, но уже не помню.
	
# Автоудаление при выходе за экран
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
