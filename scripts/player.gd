extends CharacterBody3D

@export var camera: Camera3D
@export var speed: float = 5.0
@export var jump_velocity: float = 4.5

const rotation_clamp: float = 0.5*PI
const spawn_point: Vector3 = Vector3(0.0, 1.0, 0.0)

var mouse_lock: bool = false:
	set(x): 
		if x:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
		else:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		mouse_lock = x

func _input(event: InputEvent) -> void:
	if mouse_lock and event is InputEventMouseMotion:
		rotation.y -= event.relative.x / 500
		camera.rotation.x -= event.relative.y / 750
		camera.rotation.x = clamp(camera.rotation.x, -rotation_clamp, rotation_clamp)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		mouse_lock = event.pressed

func _physics_process(delta: float) -> void:
	if global_position.y < -100.0:
		global_position = spawn_point
		velocity = Vector3.ZERO
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction: Vector3 = (transform.basis.x * input_dir.x + transform.basis.z * input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
