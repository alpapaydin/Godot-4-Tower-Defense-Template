extends Control

func	 _ready():
	Globals.hud = self
	Globals.baseHpChanged.connect(update_hp)

func update_hp(newHp, maxHp):
	%HPLabel.text = "HP: "+str(round(newHp))+"/"+str(round(maxHp))
