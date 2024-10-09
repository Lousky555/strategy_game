extends Node

func import_file(filepath:String) -> Dictionary:
	var file:FileAccess = FileAccess.open(filepath, FileAccess.READ)
	if file != null:
		var dictionary:Dictionary = JSON.parse_string(file.get_as_text().replace("_", " "))
		if dictionary != null:
			return dictionary
		else:
			printerr("There is a mistake in some geopfile!")
			get_tree().quit()
			return Dictionary()
	else :
		printerr("Failed to open file: ", filepath)
		get_tree().quit()
		return Dictionary()
