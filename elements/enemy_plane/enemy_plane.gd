extends CharacterBody2D

const SPEED = 1
const turnRate = 300.0
var HEALTH = 1
const ramDmage = 10

const bullet_scene = preload("res://elements/Bullet/bullet_2d.tscn")
var texture = preload("res://assets/plane.png")
var texture_to_left = preload("res://assets/plane_to_left.png")
var texture_to_right = preload("res://assets/plane_to_right.png")

func _physics_process(delta: float) :
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	delta = delta + SPEED
	var collision = move_and_collide(Vector2.DOWN * SPEED * delta)
	if collision:
		var collider = collision.get_collider()
		if collider and collider.has_method("shot"):
			print('RAM_EM!')
			collider.shot(ramDmage)
			queue_free()
	
func mg_fire():
	var shell = bullet_scene.instantiate()	
	shell.global_position = global_position + Vector2(-2, -40)
	add_child(shell)
	
func shot(damage):
	HEALTH -= damage
	if HEALTH < 0:
		print('Hit')
		shot_down()
		
func shot_down():
	print('Shot down!')
	queue_free()
