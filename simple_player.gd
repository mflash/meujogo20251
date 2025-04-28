extends CharacterBody2D

@export var speed = 300
@export var jump_speed = -1000
@export var gravity = 2500
@export var rotation_speed = 1.5

var rotation_direction = 0
#var target : Vector2

@onready var sprite = $PlayerSprite
#@onready var sprite = get_node("PlayerSprite")
@onready var target = position
@onready var player : AudioStreamPlayer = $Jump

@export var box : PackedScene

#func _ready() -> void:
#	pass

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
	#print(velocity)

func animate():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()

func get_side_input():
	velocity.x = 0
	var vel := Input.get_axis("ui_left", "ui_right")
	var jump := Input.is_action_pressed('ui_select')

	if is_on_floor() and jump:
		velocity.y = jump_speed
		get_tree().call_group("score", "score_jump")
		var b := box.instantiate()
		b.position = global_position
		owner.add_child(b)
		# Opcional: espera terminar a reprodução
		# anterior
		if not player.playing:
			player.play()
		
		
	velocity.x = vel * speed
	
func animate_side():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		
func _physics_process(delta: float) -> void:
	# 1. movimento em 8 direções
	#get_8way_input()
	#animate() # anima os frames
	# Mesma coisa, mas sem colisão!
	#position += velocity * delta
	#move_and_slide()
	# Ex: obtendo normal do objeto colidido
	#var col := get_last_slide_collision()
	#if col != null:
	#	print(col.get_normal())
		
	#var col := move_and_collide(velocity*delta)
	#if col:
	#	velocity = velocity.bounce(col.get_normal())*10
	#	move_and_collide(velocity*delta)
	
	# 2. gira e avança/retorna
	# get_rotation_input()
	# rotation += rotation_direction * rotation_speed * delta
	
	# 3. Gira com o mouse, avança/retorna com up/down
	# get_mouse_input()
	
	# 4. Click to move
	#velocity = position.direction_to(target) * speed
	#look_at(target)
	#if position.distance_to(target) > 5:
	#	move_and_slide()
	
	# 5. Movimento "plataforma" (lateral + salto)
	velocity.y += gravity * delta
	#print(velocity.y)
	get_side_input()
	animate_side()
	move_and_slide()
