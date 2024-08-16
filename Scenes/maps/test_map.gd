extends Node2D

var baseHP := 20.0

func _ready():
	Globals.turretsNode = $Turrets
	Globals.projectilesNode = $Projectiles
	Globals.currentMap = self

func get_base_damage(damage):
	baseHP -= damage
	if baseHP <= 0:
		print("game over")
