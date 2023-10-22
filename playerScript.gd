extends CharacterBody2D

const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimatedSprite2D")

func _ready():
	anim.play("idle")

#func _on_action_pressed(action_name):
	#if action_name == KEY_SPACE:
		#anim.play("attack")
		#print("hi")

func playerMovement():

	# Input Variables.....dont change
	var directionX = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var directionY = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Determine which animation to play based on direction
	if directionX < 0:
		get_node("AnimatedSprite2D").flip_h = true
		anim.play("runX")
	elif directionX > 0:
		get_node("AnimatedSprite2D").flip_h = false
		anim.play("runX")
		
	elif directionY == -1: # Run up
		anim.play("runUp")

	elif directionY == 1:
		anim.play("runDown") # Run down
		
	if Input.is_action_just_pressed("leftClick_Attack"):
		Attack()
		

	if directionX != 0 or directionY != 0:
		velocity.x = directionX * SPEED
		velocity.y = directionY * SPEED
		
	else:
		anim.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)


func Attack():
	anim.play("attack")

func _physics_process(delta):
	# Add the gravity.
	# if not is_on_floor():
	#     velocity.y += gravity * delta
	playerMovement()
	move_and_slide()
