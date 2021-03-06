extends Control

var loadedGames = [] 
var selectedGame

var SAVING_PATH = "user://saves"

func _ready():
	# load games and list
	#print(OS.get_user_data_dir())
	read_files()

func read_files():
	var dir = Directory.new()
	dir.open("user://")
	if not dir.dir_exists(SAVING_PATH):
		dir.make_dir(SAVING_PATH)
	dir.open(SAVING_PATH)
	
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		if file.ends_with(".txt"):
			loadedGames.append(file)
	dir.list_dir_end()
	
	load_saves_board()

func load_saves_board():
	# create label instances to add file name nodes
	for file in loadedGames:
		$LoadedGames.add_item(file, null, true)
		
func _on_LoadedGames_item_selected(index):
	selectedGame = loadedGames[index]

func _on_CancelButton_pressed():
	get_tree().change_scene("res://src/scenes/ui/Menu.tscn")

func _on_LoadButton_pressed():
	# load selected game info
	# pass it to main scene, start game!
	LoadedGames.loaded_game = selectedGame
	if LoadedGames.loaded_game != null:
		get_tree().change_scene("res://src/scenes/ui/Main.tscn")
