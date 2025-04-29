extends "res://elements/enemy/enemy.gd"

func _init() -> void:
	planes  = [default_plane, AircoDH2, FokkerEI, FokkerDrI, GothaGV, BreguetXIV]
	Entente = [AircoDH2, BreguetXIV]
	CentralEmpires = [FokkerEI, FokkerDrI, GothaGV]
	weights = [0, 5, 5, 2, 1, 0]
