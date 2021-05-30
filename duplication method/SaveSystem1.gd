extends Node2D

onready var Godot: = $Godot
onready var save_file:Dictionary={               # template of the save data
	"index" : indexer,
	"x_pos" : Godot.position.x,
	"y_pos" : Godot.position.y
}

var indexer:Dictionary = {                       # index the save file of the game 
	"index" : 0
}

var save_file_location:String ="res://save_file_"
var index_file_location:String = "res://index"


func _ready() -> void:
	reset()
	load_index()
	load_file()

	$Control/SaveFile.text = str(indexer["index"])
	return


func _on_Random_pressed() -> void:               # randomize the position
	Godot.position.x = randi() % 900+1           # generate a integer between 0 to 900
	$Control/Position.text += str(Godot.position) + "\n"
	return


func _on_Save_pressed() -> void:
	next()
	save_index()
	save_file()
	$Control/SaveFile.text = str(indexer["index"])
	return


func save_index() -> void:
	var file: = File.new()
	file.open(index_file_location, file.WRITE)
	file.store_string(to_json(indexer))        # convert the dictionary to the json
	file.close()
	return


func save_file() -> void:                      # save game file 
	save_file["x_pos"] = Godot.position.x
	
	var file: = File.new()
	file.open(save_file_location + str(indexer["index"]), file.WRITE)
	file.store_string(to_json(save_file))      # convert the dictionary to the json
	file.close()
	return


func load_file() -> void:                      # load game file
	var file: = File.new()
	file.open(save_file_location + str(indexer["index"]), file.READ)
	var data:Dictionary = parse_json(file.get_as_text()) # load the save file as dictionay
	file.close()
	
	save_file = data
	Godot.position.x = save_file["x_pos"]
	return


func load_index() -> void:                     # load game file
	var file: = File.new()
	file.open(index_file_location, file.READ)
	var data:Dictionary = parse_json(file.get_as_text()) # load the index file as dictionay
	file.close()

	indexer = data
	return


func _on_Load_pressed():
	load_index()
	load_file()
	$Control/SaveFile.text = str(indexer["index"])
	return


func _on_GoBack_pressed():                        # go back the previous save file
	previous()
	load_file()
	
	save_index()
	save_file()
	$Control/SaveFile.text = str(indexer["index"])
	return


func next() -> void:
	indexer["index"] += 1 
	return


func previous() -> void:
	indexer["index"] -= 1 
	return


func reset() -> void:
	var test: = File.new()
	if test.file_exists("res://index") or test.file_exists(save_file_location+str(indexer["index"])):
		pass
	else:
		save_index()
		save_file()
	return
