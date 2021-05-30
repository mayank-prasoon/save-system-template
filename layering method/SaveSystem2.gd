extends Node2D

onready var Godot:= $Godot
onready var positions:Array = [                      # template of save file
	{
	"uid":0,
	"position_x":Godot.position.x,
	"position_y":Godot.position.y
	}
]

func _ready() -> void:
	load_index()
	load_snapshot()
	load_save()
	load_postion()

var index_value:int = 0
var snapshot:Array = [0]

func create_new_snapshot() ->void:
	index_value += 1
	snapshot.append(index_value)
	return

func create_position_layer() -> void:                 # creates layers of data
	positions.append({
		"uid": snapshot[-1],
		"position_x": Godot.position.x,
		"position_y": Godot.position.y
		}
	)
	return

func delete_snapshot(snapshot_index:int) -> void:
	for _x in range(snapshot_index):
		snapshot.pop_back()
	return

func load_postion() -> void:                          # loads the postion
	var temp:Array = []

	for x in positions:
		if x["uid"] == snapshot[-1]:
			temp.append(x)

	var pos_x:float = temp[-1]["position_x"]          # x postion
	var pos_y:float = temp[-1]["position_y"]          # y postion

	Godot.position = Vector2(pos_x, pos_y)            # curret position of the sprite 
	return


# this block of code is borrowed  
# https://gdscript.com/solutions/how-to-save-and-load-godot-game-data/

func save() -> void:
	print("save")
	var file:= File.new()
	file.open("res://save_game.json", File.WRITE)
	file.store_string(to_json(positions))
	file.close()
	return

func load_save() -> void:
	var file:= File.new()
	if file.file_exists("res://save_game.json"):
		file.open("res://save_game.json", File.READ)
		var data:Array = parse_json(file.get_as_text())
		file.close()

		positions = data

	else:
		printerr("No saved data!")                     # I don't know what this do
		save()
	return

func save_index() -> void:
	print("save index")
	var file:= File.new()
	file.open("res://layer_index.json", File.WRITE)
	file.store_string(to_json(index_value))
	file.close()
	return

func load_index() -> void:
	var file:= File.new()
	if file.file_exists("res://layer_index.json"):
		file.open("res://layer_index.json", File.READ)
		var data:int = parse_json(file.get_as_text())
		file.close()

		index_value = data

	else:
		printerr("No saved data!")                      # I don't know what this do
		save_index()
	return

func save_snapshot() -> void:
	print("save snapshot")
	var file:= File.new()
	file.open("res://layer_snapshot.json", File.WRITE)
	file.store_string(to_json(snapshot))
	file.close()
	return

func load_snapshot() -> void:
	var file:= File.new()
	if file.file_exists("res://layer_snapshot.json"):
		file.open("res://layer_snapshot.json", File.READ)
		var data:Array = parse_json(file.get_as_text())
		file.close()

		snapshot = data
		
	else:
		printerr("No saved data!")                      # I don't know what this do
		save_snapshot()
	return

