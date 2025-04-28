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
		"level1_btn":
			get_tree().change_scene_to_file("res://Game/levels/dh2-mission/dh2-mis.tscn")
		"level2_btn":
			get_tree().change_scene_to_file("res://Game/levels/fokkerDrI-mission/fokkerDrI-mis.tscn")
		"level3_btn":
			get_tree().change_scene_to_file("res://Game/game_scene.tscn")
		"ExitButton":
			get_tree().quit()  # Для мобильных платформ используйте SceneTree.quit()
	# Кнопка выхода
	#var exit_button = Button.new()
	#exit_button.text = "Выход"
	#exit_button.pressed.connect(_on_exit_pressed)
	#$VBoxContainer.add_child(exit_button)

func _load_level(index: int):
	get_tree().change_scene_to_file(levels[index])

func _on_exit_pressed():
	get_tree().quit()
