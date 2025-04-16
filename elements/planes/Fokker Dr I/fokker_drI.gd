class_name Fighter
extends Planes



func  _ready() -> void:
	HEALTH = 5
	ramDmage = 10
	SPEED = 185 #r крейсерская 140; максимальная 185
	turnRate = 300.0
	fireRate = 0.12 * 0.5 # 2 * MG08
	AMMO = 800 # Хз сколько 
	
	texture = preload("res://assets/FokkerDrI/fokker_dr1.png")
	texture_to_left = preload("res://assets/FokkerDrI/fokker_dr1_to_left.png")
	texture_to_right = preload("res://assets/FokkerDrI/fokker_dr1_to_right.png")
