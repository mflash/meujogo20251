extends Label

var score := 0

func _ready() -> void:
	text = "Score: "+str(score)

func _on_timer_timeout() -> void:
	score += 1
	text = "Score: "+str(score)

func score_jump() -> void:
	score += 5
	text = "Score: "+str(score)
