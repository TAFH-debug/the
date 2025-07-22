extends CharacterBody3D

@onready var gun: Node3D = $Sprite/Gun
@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/SpringArm3D/Camera3D
@onready var cam_arm: SpringArm3D = $Head/SpringArm3D
@onready var sprite: AnimatedSprite3D = $Sprite
@export var FLIP_SPEED: float = 15.0
@export var SPEED: float = 1.8
@export var JUMP_VELOCITY: float = 3.0
@export var SENSITIVITY: float = 0.004
var face_right: bool = true
var base_angle: float = 0.0




func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print(head.rotation.x)
	
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		#cam_arm.rotate_x(-event.relative.y * SENSITIVITY)
		cam_arm.rotation.x = clamp(cam_arm.rotation.x, deg_to_rad(-90), deg_to_rad(0))
		base_angle = head.rotation.y
		
		sprite.rotate_y(-event.relative.x * SENSITIVITY)
		#gun.rotate_y(-event.relative.x * SENSITIVITY)
func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := (transform.basis.rotated(Vector3(0, 1, 0), base_angle) * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
#	flipping logic
	
	if input_dir.x > 0.0: 
		face_right = true
	elif input_dir.x < 0.0:
		face_right = false
		
	if face_right:
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, rad_to_deg(base_angle), FLIP_SPEED)
	else:
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, rad_to_deg(base_angle) + 180, FLIP_SPEED)
