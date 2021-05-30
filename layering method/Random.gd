extends Button

onready var Godot: = $"../../Godot"

func _on_Random_pressed() -> void:
	Godot.random_postion()
	return
