extends Control

var gameScene: PackedScene

func _ready() -> void:
	await RenderingServer.frame_post_draw
	
	gameScene = load("res://scenes/game.tscn")
	
	$VBoxContainer/start.pressed.connect(play)
	$VBoxContainer/quit.pressed.connect(get_tree().quit)
	$VBoxContainer/Label.visible = false
	$VBoxContainer/start.visible = true
	$VBoxContainer/quit.visible = true

func play() -> void:
	get_tree().change_scene_to_packed(gameScene)
