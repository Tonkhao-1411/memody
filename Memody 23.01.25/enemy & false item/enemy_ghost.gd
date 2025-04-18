extends RigidBody2D

@onready var game_manager_live = %GameManager_live

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
