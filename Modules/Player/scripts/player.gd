extends CharacterBody3D

@export_category("Movement Settings")
@export var playerSpeed = 5.0
@export var jumpForce = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Object references
@onready var playerCamera = $Neck

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * 0.01)
			playerCamera.rotate_x(-event.relative.y * 0.01)
			playerCamera.rotation.x = clamp(playerCamera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta):
	if Input.is_action_just_pressed("g_escape"):
		get_tree().quit()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpForce

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("m_left", "m_right", "m_up", "m_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * playerSpeed
		velocity.z = direction.z * playerSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, playerSpeed)
		velocity.z = move_toward(velocity.z, 0, playerSpeed)

	move_and_slide()
