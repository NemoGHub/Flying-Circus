extends "res://elements/enemy/enemy.gd"

func _init() -> void:
	planes  = [default_plane, AircoDH2, FokkerDrI, GothaGV, BreguetXIV]
	Entente = [AircoDH2, BreguetXIV]
	CentralEmpires = [FokkerDrI, GothaGV]
	weights = [0, 3, 3, 1, 0]
