extends CharacterBody3D

@onready var sprite: AnimatedSprite3D = $Sprite
@export var FLIP_SPEED: float = 15.0
var face_right: bool = true

@export var SPEED: float = 1.8
@export var JUMP_VELOCITY: float = 3.0

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
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
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, 0.0, FLIP_SPEED)
	else:
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, 180.0, FLIP_SPEED)
