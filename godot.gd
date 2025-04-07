extends Sprite2D

const SPEED : int = 200

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= SPEED * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += SPEED * delta
	if Input.is_action_pressed("ui_right"):
		position.x += SPEED * delta
	elif Input.is_action_pressed("ui_left"):
		position.x -= SPEED * delta
