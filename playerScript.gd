extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimatedSprite2D")

func _ready():
	anim.play("idleAnim")
	
func playerMovement():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	
	# Run Left and Right
	if directionX == -1: # Run Left
		get_node("AnimatedSprite2D").flip_h = true

	elif directionX == 1: # Run Right
		get_node("AnimatedSprite2D").flip_h = false

	if directionX:
		velocity.x = directionX * SPEED
		anim.play("runX")
		if directionX and directionY: #try and run sideways up and down is pressed...
			anim.play("runX")
			
	#else: 
		#anim.play("idle")
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	# Run Up and Down
	if directionY == -1:
		#velocity.y = directionY * SPEED
		anim.play("runUp")

	elif directionY == 1:
		#velocity.y = directionY * SPEED
		anim.play("runDown")

	if directionY:
		velocity.y = directionY * SPEED

	#If Nothing is pressed (not X/Y)
	if not directionX and not directionY:
		anim.play("idle")
		#anim.play(anim)
		velocity.x = move_toward(velocity.x, 0, SPEED) # Set to nothing
		velocity.y = move_toward(velocity.y, 0, SPEED) # Set to nothing

func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
	playerMovement()
	move_and_slide() #idk what this is lmao
