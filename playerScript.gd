extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")

const SPEED = 275.00

func _ready():
	anim.play("idle")

func playerMovement():
	# Input Variables.....dont change
	var directionX = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var directionY = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Attack....not working
		
	#Determine which animation to play based on direction
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

	if directionX != 0 or directionY != 0:
		velocity.x = directionX * SPEED
		velocity.y = directionY * SPEED
		
	if Input.is_action_pressed("leftClick_Attack"):
		anim.play("attackX")
	else:
		if get_node("AnimatedSprite2D").animation != "attackX":
			anim.play("idle")
		#anim.play("idle")
			
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)


func _physics_process(delta):
	# Add the gravity.
	# if not is_on_floor():
	#     velocity.y += gravity * delta

	playerMovement()
	move_and_slide()
