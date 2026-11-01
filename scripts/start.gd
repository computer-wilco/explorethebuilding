extends Control

var gameScene: PackedScene = load("res://scenes/game.tscn")

func _ready() -> void:
	$VBoxContainer/start.pressed.connect(play)
	$VBoxContainer/quit.pressed.connect(get_tree().quit)

func play() -> void:
	get_tree().change_scene_to_packed(gameScene)
