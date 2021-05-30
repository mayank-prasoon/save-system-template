extends Sprite

func random_postion() -> void:                   # randomize the position
	position.x = randi() % 900+1               # generate a integer between 0 to 900
	return
