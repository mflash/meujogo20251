extends Node2D

var player : CharacterBody2D
var scene_limit : Marker2D

var current_scene = null

func _ready() -> void:
	var qtd_filhos = get_child_count()
	# Assumindo que o level é SEMPRE o último
	# nodo da cena!
	var level = get_child(qtd_filhos-1)
	player = level.get_node("SimplePlayer")
	scene_limit = level.get_node("SceneLimit")
	
func _physics_process(delta: float) -> void:
	if scene_limit == null:
		scene_limit = current_scene.get_node("SceneLimit")
		player = current_scene.get_node("SimplePlayer")
	if player.position.y > scene_limit.position.y:
		print("PERDEU!")
		get_tree().change_scene_to_file("res://game_over.tscn")
		
	if Input.is_key_pressed(KEY_X):
		call_deferred("goto_scene", "res://levels/level_2.tscn")

func goto_scene(path: String):
	var total_filhos = get_child_count()
	print("Total children: "+str(total_filhos))
	var world := get_child(total_filhos-1)
	world.free()
	var new_scene : PackedScene = ResourceLoader.load(path)
	current_scene = new_scene.instantiate()
	scene_limit = null # indica a troca de cena
	get_tree().get_root().add_child(current_scene)	
