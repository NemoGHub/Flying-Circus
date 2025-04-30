extends "res://elements/enemy/enemy.gd"

func _init() -> void:
	planes  = [default_plane, AircoDH2, FokkerEI, MoS3]
	Entente = [AircoDH2, MoS3]
	CentralEmpires = [ FokkerEI]
	weights = [0, 1, 2, 3]
