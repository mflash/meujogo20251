extends Area2D

func _ready() -> void:
	# Alternativa: animando por código
	# através de tweens
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.2)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
	   
func _on_screen_exited() -> void:
	#print("Saí da tela!")
	queue_free()
