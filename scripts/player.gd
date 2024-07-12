extends CharacterBody2D

var SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# система прыжков с возможностью нескольких подряд
var jumps = 0
var air_jumps_allowed = 1

# пауза
#@onready var pause_menu = $Camera2D/PauseMenu
var paused = false
#func pauseMenu():
	#if paused:
		#pause_menu.hide()
		#Engine.time_scale = 1
	#else:
		#pause_menu.show()
		#Engine.time_scale = 0
	#paused = !paused

func jump():
	if Input.is_action_just_pressed("jump_space") and jumps <= air_jumps_allowed:
		velocity.y = JUMP_VELOCITY + 100
		jumps += 1
		if jumps <= 1:
			velocity.y = JUMP_VELOCITY
	elif jumps != 0 and is_on_floor():
		jumps = 0
	#print(jumps)

# анимация персонажа
func _process(_delta):
	if velocity.x != 0:
		$AnimatedSprite2D.play('walk')
		$AnimatedSprite2D.flip_h = velocity.x > 0
	if not is_on_floor():
		$AnimatedSprite2D.play('jump')
	if is_on_floor() and velocity.x == 0:
		$AnimatedSprite2D.play('calm')
	
	#if Input.is_action_just_pressed("escape"):
		#pauseMenu()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	jump()
	
	if not is_on_floor():
		SPEED += 1
	else:
		SPEED = 200
		
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	


