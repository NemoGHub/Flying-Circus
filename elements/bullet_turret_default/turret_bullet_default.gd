class_name Turret_Bullet
extends Bullet

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(Vector2(direction, 1.0) * SPEED * delta)
	if collision:
		hit(delta, collision)
