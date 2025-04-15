class_name Planes

extends CharacterBody2D

var isPlayer := false  

var HEALTH = 10
var HEALTH_remains = HEALTH
var ramDmage = 10
var SPEED = 100
var turnRate = 150.0
var fireRate = 0.2
var AMMO = 100
var time_since_last_shot = 0.0
var direction


var bullet_scene = preload("res://elements/Bullet/bullet_2d.tscn")
var texture = preload("res://assets/default_plane/plane.png")
var texture_to_left = preload("res://assets/default_plane/plane_to_left.png")
var texture_to_right = preload("res://assets/default_plane/plane_to_right.png")


func _physics_process(delta: float) :
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if isPlayer:
		if Input.is_action_pressed("ui_accept"):
			if AMMO > 0:			
				time_since_last_shot += delta
				if time_since_last_shot >= fireRate:
					mg_fire()
					time_since_last_shot = 0.0
					print("Fire! MG08 left: " + str(AMMO))
		
		var direction := Input.get_axis("ui_left", "ui_right")
		#print(direction)
		match direction:
			-1.0: $Sprite2D.texture = texture_to_left
			1.0: $Sprite2D.texture = texture_to_right
			_:	$Sprite2D.texture = texture
		velocity.x = direction * turnRate
	#global_position.x = direction * SPEED * delta
		move_and_slide()
	
	
func mg_fire():
	animate_fire()
	AMMO -= 1
	var shell = bullet_scene.instantiate()	
	shell.global_position = global_position + Vector2(0, -50)
	add_child(shell)

	
func animate_fire():
	$Sprite2D/tratata.play("tratata")
	
func shot(damage):
	HEALTH -= damage
	if HEALTH < 0:
		print('Hit')
		shot_down()
		
func shot_down():
	print('Shot down!')
	queue_free()
	
	
	
	
