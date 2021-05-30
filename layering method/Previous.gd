extends Button

onready var SaveGame: = $"../.."

func _on_Previous_pressed() -> void:
	SaveGame.delete_snapshot(1)
	SaveGame.save_index()
	SaveGame.save_snapshot()
	SaveGame.load_postion()
	return
