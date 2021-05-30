extends Button

onready var SaveGame: = $"../.."

func _on_Load_pressed() -> void:
	SaveGame.load_index()
	SaveGame.load_snapshot()
	SaveGame.load_save()
	SaveGame.load_postion()
	return
