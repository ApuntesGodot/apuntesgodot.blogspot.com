class_name Jugador  extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4

var xform : Transform3D

func _physics_process(delta: float) -> void:
	#!!! NEW LINE
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() and input_dir != Vector2.ZERO:
		$AnimationPlayer.play("run")
	elif is_on_floor() and input_dir == Vector2.ZERO:
		$AnimationPlayer.play("idle")
		
	
	if Input.is_key_pressed(KEY_A):
		$Camera_Controller.rotate_y(deg_to_rad(5))
		
	if Input.is_key_pressed(KEY_D):
		$Camera_Controller.rotate_y(deg_to_rad(-5))			

		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		SoundManager.play_jump_sound()
		velocity.y = JUMP_VELOCITY


	
	var direction = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if input_dir != Vector2(0,0):
	#!!! NEW LINE
		$Armature.rotation_degrees.y = $Camera_Controller.rotation_degrees.y - rad_to_deg(input_dir.angle())	+ 90

	if is_on_floor() and input_dir != Vector2(0,0):
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform, 0.3)
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, 0.3)
	
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
 
	$Camera_Controller.position = lerp($Camera_Controller.position,position, 0.15)

func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()



func bounce():
	velocity.y = JUMP_VELOCITY * 0.7



func _on_fallzone_body_entered(body: Node3D) -> void:
	SoundManager.play_fall_sound()
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
