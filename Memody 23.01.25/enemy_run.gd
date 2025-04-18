extends CharacterBody2D

@onready var game_manager_live = %GameManager_live

func _on_area_2d_area_entered(area):
	if (area.name == "Rock_character"):
		print("1")
		$AnimatedSprite2D.play("dead_enemy")
		await get_tree().create_timer(0.75).timeout
		queue_free()

func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		if (y_delta < -7):
			print("dead c")
			game_manager_live.decrease_health()
		print(y_delta)

var SPEED = -150.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()

	velocity.x = SPEED
	move_and_slide()

func flip() :
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right :
		SPEED = abs(SPEED)
		#animated_sprite_2d.animation = "run_chick"
	else :
		SPEED = abs (SPEED) * -1
		#animated_sprite_2d.animation = "run_chick"


	move_and_slide()
