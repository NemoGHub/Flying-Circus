extends CharacterBody2D

const SPEED = 1.3
const turnRate = 300.0
const HEALTH = 1
var HEALTH_remains = HEALTH
const ramDmage = 10
var direction = 0



const bullet_scene = preload("res://elements/Bullet/bullet_2d.tscn")
var smoke_scene = preload("res://elements/effects/smoke/smoke.tscn")

var texture = preload("res://assets/default_plane/plane.png")
var texture_to_left = preload("res://assets/default_plane/plane_to_left.png")
var texture_to_right = preload("res://assets/default_plane/plane_to_right.png")



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
	if HEALTH_remains < 0:
		fall()
	#if HEALTH_remains < HEALTH:
		#var smoke = smoke_scene.instantiate()
		#add_child(smoke) 
	
func mg_fire():
	var shell = bullet_scene.instantiate()	
	shell.global_position = global_position + Vector2(-2, -40)
	add_child(shell)
	
func shot(damage):
	HEALTH_remains -= damage
	if HEALTH_remains < 0:
		print('Hit')
		shot_down()
		
func shot_down():
	print('Shot down!')
	direction = randf_range(-1.0, 1.0)
	$Timer.wait_time = randf_range(0.0, 10.0)
	$Timer.start()
	
func fall():
	#var smoke = smoke_scene.instantiate()
	#add_child(smoke) 
	if direction > 0.0:
		$Sprite2D.texture = texture_to_right
	elif direction < 0.0:
		$Sprite2D.texture = texture_to_left
	else:
		$Sprite2D.texture = texture
	if $Sprite2D.scale < Vector2(0.5, 0.5):
		queue_free()
	$Sprite2D.scale -= Vector2(0.005, 0.005)
	velocity.x = direction * turnRate
	velocity.y *= 1.5
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()
