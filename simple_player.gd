extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0
#var target : Vector2

@onready var target = position

#func _ready() -> void:
#	target = position

# 4. Click to move (seta a posição do alvo)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()

# 3. Gira com o mouse, avança/retorna com up/down
func get_mouse_input():
	look_at(get_global_mouse_position())
	velocity = transform.x * Input.get_axis("ui_down", "ui_up") * speed
	
# 2. Gira com left/right, avança/retorna com up/down
func get_rotation_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	#print("Transform.x:", transform.x)
	velocity = transform.x * Input.get_axis("ui_down", "ui_up") * speed

# 1. Movimento em 8 direções
func get_8way_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	print(velocity)
	
func _physics_process(delta: float) -> void:
	# 1. movimento em 8 direções
	#get_8way_input()
	# Mesma coisa, mas sem colisão!
	#position += velocity * delta
	
	# 2. gira e avança/retorna
	# get_rotation_input()
	# rotation += rotation_direction * rotation_speed * delta
	
	# 3. Gira com o mouse, avança/retorna com up/down
	# get_mouse_input()
	
	# 4. Click to move
	velocity = position.direction_to(target) * speed
	#look_at(target)
	if position.distance_to(target) > 5:
		move_and_slide()
