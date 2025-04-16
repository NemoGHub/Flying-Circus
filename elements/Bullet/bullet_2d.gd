extends CharacterBody2D


const SPEED = 800.0 * 2
const DAMAGE = 1
var collision_effect = preload("res://elements/effects/small_hit/small_hit.tscn")

func _ready():
	# Проверка загрузки текстуры
	if $Sprite2D.texture == null:
		print("Ошибка: текстура пули не назначена!")

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(Vector2.UP * SPEED * delta)
	if collision:
		hit(delta, collision)

			
func hit(delta: float, collision):
			#add_sibling(collision_effect.instantiate())
		set_physics_process(false)
		add_child(collision_effect.instantiate())
		var collider = collision.get_collider()
		if collider and collider.has_method("shot"):
			print('Попадание')
			collider.shot(DAMAGE)
		$CollisionShape2D.queue_free()
		$Sprite2D.queue_free()
		move_local_y(delta * 100)
	
# Автоудаление при выходе за экран
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
