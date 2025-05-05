extends CanvasLayer

@onready var speed_label = $SpeedLabel
@onready var ammo_label = $AmmoLabel
@onready var health_label = $HealthLabel
@onready var victories_label = $VictoriesLabel


func update_display(speed: float, ammo: int, health, victories: int):
	speed_label.text = "Speed: %d км/ч" % speed
	ammo_label.text = "MG: %d" % [ammo] 
	health_label.text = "HP: %d " % [health]
	victories_label.text = "♤ %d " % [victories] # ♠
