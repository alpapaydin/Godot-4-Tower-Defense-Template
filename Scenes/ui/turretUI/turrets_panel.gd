extends PanelContainer

func _ready():
	populate_turret_containers()
	
func populate_turret_containers():
	for c in $Turrets.get_children():
		c.queue_free()
	var panelScene := preload("res://Scenes/ui/turretUI/turret_buy_container.tscn")
	for turret in Data.turrets.keys():
		var newPanel := panelScene.instantiate()
		$Turrets.add_child(newPanel)
		newPanel.turret_type = turret
