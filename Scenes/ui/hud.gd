extends Control

var next_wait_time := 0
var waited := 0
var open_details_pane : PanelContainer

func	 _ready():
	Globals.hud = self
	Globals.baseHpChanged.connect(update_hp)
	Globals.goldChanged.connect(update_gold)
	Globals.waveStarted.connect(show_wave_count)
	Globals.waveCleared.connect(show_wave_timer)
	Globals.enemyDestroyed.connect(update_enemy_count)

func update_hp(newHp, maxHp):
	%HPLabel.text = "HP: "+str(round(newHp))+"/"+str(round(maxHp))

func update_gold(newGold):
	%GoldLabel.text = "Gold: "+str(round(newGold))

func show_wave_count(current_wave, enemies):
	$WaveWaitTimer.stop()
	waited = 0
	%WaveLabel.text = "Current Wave: "+str(current_wave)
	%RemainLabel.text = "Enemies: "+str(enemies)
	%RemainLabel.visible = true
	
func show_wave_timer(wait_time):
	%RemainLabel.visible = false
	next_wait_time = wait_time-1
	$WaveWaitTimer.start()

func _on_wave_wait_timer_timeout():
	%WaveLabel.text = "Next wave in "+str(next_wait_time-waited)
	waited += 1

func update_enemy_count(remain):
	%RemainLabel.text = "Enemies: "+str(remain)

func reset():
	if is_instance_valid(open_details_pane):
		open_details_pane.turret.close_details_pane()
