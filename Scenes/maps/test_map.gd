extends Node2D

var gameOver := false
var baseMaxHp := 20.0
var baseHP := baseMaxHp

func _ready():
	Globals.turretsNode = $Turrets
	Globals.projectilesNode = $Projectiles
	Globals.currentMap = self
	Globals.baseHpChanged.emit(baseHP, baseMaxHp)

func get_base_damage(damage):
	if gameOver:
		return
	baseHP -= damage
	Globals.baseHpChanged.emit(baseHP, baseMaxHp)
	if baseHP <= 0:
		gameOver = true
		var gameOverPanelScene := preload("res://Scenes/ui/gameOver/game_over_panel.tscn")
		var gameOverPanel := gameOverPanelScene.instantiate()
		Globals.hud.add_child(gameOverPanel)
