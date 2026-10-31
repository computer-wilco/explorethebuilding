extends Control

func _ready() -> void:
	$VBoxContainer/start.pressed.connect(play)
	$VBoxContainer/quit.pressed.connect(quit)

func quit() -> void:
	await get_tree().create_timer(0.25).timeout
	
	get_tree().quit()

func play() -> void:
	get_tree().change_scene_to_packed(preload("res://scenes/game.tscn"))
