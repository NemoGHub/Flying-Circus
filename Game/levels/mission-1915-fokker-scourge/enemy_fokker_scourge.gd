extends "res://elements/enemy/enemy.gd"
const FokkerEI = preload("res://elements/planes/Fokker E I/fokker_EI.tscn")

func _init() -> void:
	planes  = [default_plane, AircoDH2, FokkerEI, GothaGV, BreguetXIV]
	Entente = [AircoDH2, BreguetXIV]
	CentralEmpires = [ FokkerEI, GothaGV]
	weights = [0, 1, 1, 0, 0]
