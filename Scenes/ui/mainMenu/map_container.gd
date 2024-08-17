extends PanelContainer

var map_id := "":
	set(val):
		map_id = val
		$TextureRect.texture = load(Data.maps[val]["bg"])
		$Label.text = Data.maps[val]["name"]

func _on_gui_input(_event):
	if Input.is_action_just_pressed("LeftClick"):
		Globals.selected_map = map_id
		get_tree().change_scene_to_file("res://Scenes/main/main.tscn")
