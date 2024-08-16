extends Node

@warning_ignore("unused_signal")
signal goldChanged(newGold)
@warning_ignore("unused_signal")
signal baseHpChanged(newHp, maxHp)


var turretsNode : Node2D
var projectilesNode : Node2D
var currentMap : Node2D
var hud : Control

@onready var mainNode := get_node("/root/main")
func restart_current_level():
	var currentLevelScene := load(currentMap.scene_file_path)
	currentMap.queue_free()
	var newMap = currentLevelScene.instantiate()
	mainNode.add_child(newMap)
	
