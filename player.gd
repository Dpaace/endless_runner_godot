extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 8

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var score = 0
var game_over = false

func _physics_process(delta):
	if game_over:
		return

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Vector2(0, 0)  # Initialize input direction as (0, 0)
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1  # Move left
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1  # Move right

	var direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	var collision = get_last_slide_collision()
	if collision:
		print("Collided with: ", collision.get_collider())
		#get_tree().quit()
