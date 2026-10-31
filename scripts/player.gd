extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

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
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
