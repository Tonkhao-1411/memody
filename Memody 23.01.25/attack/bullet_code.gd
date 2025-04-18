extends Area2D

@export var speed = 600
var direction : Vector2
var flip_h = false
@export var enemy : Array[Node]

func _ready():
	await get_tree().create_timer(0.35).timeout
	queue_free()

func set_direction(bulletDirection):
	direction = bulletDirection
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position+direction))

func _physics_process(delta):
	
		var direction = -1 if flip_h else 1
		position.x += direction * speed * delta

#func _on_body_entered(body):
	#if (body.name == "enemy"):
		# ถ้าวัตถุนั้นเป็นศัตรู ให้เรียกฟังก์ชันฆ่าศัตรู
		#body.queue_free()
