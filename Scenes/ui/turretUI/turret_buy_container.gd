extends PanelContainer

var turret_type := "":
	set(value):
		turret_type = value
		$TextureRect.turretType = value
		$TextureRect.texture = load(Data.turrets[value]["sprite"])
		$CostLabel.text = str(Data.turrets[value]["cost"])

var can_purchase := false:
	set(value):
		can_purchase = value
		$CantBuy.visible = not value
