extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var marker_2d = $Marker2D
var direction = Vector2.ZERO
var isShooting = false
var preloadRock = preload("res://attack/bullet.tscn")
@onready var character = $"."


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0
#control walk run (left,right)

func jump() :
	velocity.y = JUMP_VELOCITY


func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		jump_count = 0
	else:
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("Attack"):
		character.shoot()
		%AnimatedSprite2D.play("attack")
	
	if (velocity.x > 1 || velocity.x < -1 ) :
		animated_sprite_2d.animation = "run"
	else :
		animated_sprite_2d.animation = "idle"

# Handle jump.
	if Input.is_action_just_pressed("Jump") and jump_count < 3:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		animated_sprite_2d.play("jump")


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	


	move_and_slide()
	
	var isLeft = velocity.x<0
	animated_sprite_2d.flip_h = isLeft

#control attack
func shoot():
	#if Input.is_action_just_pressed("Attack"):
	if not isShooting :
		isShooting = true
		await get_tree().create_timer(0.1).timeout
		var Rock = preloadRock.instantiate()
		Rock.set_position($Rock.global_position)
		Rock.flip_h = animated_sprite_2d.flip_h
		get_parent().add_child(Rock)
		await get_tree().create_timer(0).timeout
		isShooting = false
