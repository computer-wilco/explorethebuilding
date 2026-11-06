extends Control

@export var label: Label
@export var player: CharacterBody3D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_debug_menu") and label:
		label.visible = !label.visible
		set_process(label.visible)

func _process(_delta: float) -> void:
	if not label or not player:
		return
	
	var pos = player.global_position
	label.text = "FPS: %d\nXYZ: %.2f %.2f %.2f" % [Engine.get_frames_per_second(), pos.x, pos.y, pos.z]
