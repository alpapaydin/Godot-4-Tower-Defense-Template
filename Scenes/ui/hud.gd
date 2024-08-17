extends Control

func	 _ready():
	Globals.hud = self
	Globals.baseHpChanged.connect(update_hp)
	Globals.goldChanged.connect(update_gold)

func update_hp(newHp, maxHp):
	%HPLabel.text = "HP: "+str(round(newHp))+"/"+str(round(maxHp))

func update_gold(newGold):
	%GoldLabel.text = "Gold: "+str(round(newGold))
