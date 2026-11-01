extends CharacterBody3D

@export var camera: Camera3D
var mouse_lock: bool = false:
	set(x): 
		if x:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
		else:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		mouse_lock = x

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if mouse_lock:
			rotation.y -= event.relative.x / 500
			camera.rotation.x -= event.relative.y / 750
			camera.rotation.x = clamp(camera.rotation.x, -0.5*PI, 0.5*PI)
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			mouse_lock = event.pressed

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = 4.5
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * 5.0
		velocity.z = direction.z * 5.0
	else:
		velocity.x = move_toward(velocity.x, 0, 5.0)
		velocity.z = move_toward(velocity.z, 0, 5.0)
	
	move_and_slide()
