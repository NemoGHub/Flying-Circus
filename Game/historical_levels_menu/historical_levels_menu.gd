extends Control

var levels: Array[String] = [
	"res://Game/game_scene.tscn",
	"res://Game/levels/dh2-mission/dh2-mis.tscn",
	"res://Game/levels/fokkerDrI-mission/fokkerDrI-mis.tscn"
]

func _ready():
	for button in $VBoxContainer.get_children():
		if button is Button:
			button.pressed.connect(_on_button_pressed.bind(button.name))
	
func _on_button_pressed(button_name: String):
	match button_name:
		
		"level_fokker_scourge_btn":
			get_tree().change_scene_to_file("res://Game/levels/mission-1915-fokker-scourge/mission_1915_fokker_scourge.tscn")
		"level_dh2_strikes_back_btn":
			get_tree().change_scene_to_file("res://Game/levels/dh2-mission/dh2-mis.tscn")
		"level_the_red_baron_btn":
			get_tree().change_scene_to_file("res://Game/levels/fokkerDrI-mission/fokkerDrI-mis.tscn")
		"BackButton":
			get_tree().change_scene_to_file("res://Game/main_menu/main_menu.tscn")
	# Кнопка выхода
	#var exit_button = Button.new()
	#exit_button.text = "Выход"
	#exit_button.pressed.connect(_on_exit_pressed)
	#$VBoxContainer.add_child(exit_button)

func _load_level(index: int):
	get_tree().change_scene_to_file(levels[index])

func _on_exit_pressed():
	get_tree().quit()
