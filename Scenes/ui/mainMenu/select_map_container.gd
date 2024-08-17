extends PanelContainer

func _ready():
	populate_maps()
	
func populate_maps():
	var mcs := preload("res://Scenes/ui/mainMenu/map_container.tscn")
	for map in Data.maps.keys():
		var mapCont := mcs.instantiate()
		mapCont.map_id = map
		%MapsList.add_child(mapCont)
