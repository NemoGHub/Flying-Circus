extends Planes



func  _ready() -> void:
	HEALTH = 10
	ramDmage = 10
	SPEED = 110
	turnRate = 300.0
	fireRate = 0.12
	AMMO = 800
	
	texture = preload("res://assets/FokkerDrI/fokker_dr1.png")
	texture_to_left = preload("res://assets/FokkerDrI/fokker_dr1_to_left.png")
	texture_to_right = preload("res://assets/FokkerDrI/fokker_dr1_to_right.png")
