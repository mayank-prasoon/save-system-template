extends Button

onready var SaveGame: = $"../.."

func _on_Save_pressed() -> void:
	SaveGame.create_new_snapshot()
	SaveGame.create_position_layer()
	SaveGame.save_index()
	SaveGame.save_snapshot()
	SaveGame.save()
	return
