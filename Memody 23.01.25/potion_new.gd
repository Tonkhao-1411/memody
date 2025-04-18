extends Area2D

@onready var game_manager_score = %GameManager_score
var is_collected = false

func _on_body_entered(body):
	if (body.name == "CharacterBody2D") and not is_collected:
		is_collected = true
		$AudioStreamPlayer2D.play()
		hide()
		$AnimatedSprite2D.play("effect_potion")
		await get_tree().create_timer(0.5).timeout
		queue_free()
		game_manager_score.add_point()
