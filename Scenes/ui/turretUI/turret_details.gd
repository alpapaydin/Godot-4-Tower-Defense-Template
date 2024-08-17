extends PanelContainer

var turret : Node2D
const sell_modifier := 0.7

func _ready():
	Globals.goldChanged.connect(check_can_upgrade)
	turret.turretUpdated.connect(set_props)
	set_props()
	animate_appear()
	check_can_upgrade()

func animate_appear():
	var tween := create_tween()
	tween.tween_property(self, "position", Vector2(500,0), 0.01).as_relative()
	tween.tween_property(self, "position", Vector2(-500,0), 0.3).as_relative()

func set_props():
	%TurretTexture.texture = load(Data.turrets[turret.turret_type]["sprite"])
	%TurretName.text = Data.turrets[turret.turret_type]["name"]
	%TurretLevel.text = "Level "+str(turret.turret_level)
	%DamageLabel.text = "Damage: "+str(round(turret.damage))
	%SpeedLabel.text = "Speed: "+str(round(turret.attack_speed))
	%RangeLabel.text = "Range: "+str(round(turret.attack_range))
	%PierceLabel.text = "Pierce: "+str(turret.bulletPierce)
	%UpgradeButton.text = "Upgrade for "+str(get_upgrade_price())
	%SellButton.text = "Sell for "+str(get_sell_price())

func _on_upgrade_button_pressed():
	if check_can_upgrade():
		Globals.currentMap.gold -= get_upgrade_price()
		turret.upgrade_turret()
		check_can_upgrade()

func get_upgrade_price():
	return turret.turret_level * Data.turrets[turret.turret_type]["upgrade_cost"]

func get_sell_price():
	var total_cost = Data.turrets[turret.turret_type]["cost"]
	for i in range(turret.turret_level):
		total_cost += i*Data.turrets[turret.turret_type]["upgrade_cost"]
	return round(total_cost * sell_modifier)

func check_can_upgrade(_new_gold=0):
	if turret.turret_level == Data.turrets[turret.turret_type]["max_level"]:
		%UpgradeButton.text = "Maxed Out"
		%UpgradeButton.disabled = true
	else:
		%UpgradeButton.disabled = Globals.currentMap.gold < get_upgrade_price()
	return not %UpgradeButton.disabled


func _on_sell_button_pressed():
	queue_free()
	Globals.currentMap.gold += get_sell_price()
	turret.queue_free()
