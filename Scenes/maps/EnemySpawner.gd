extends Path2D
class_name EnemyPath

var map_type := "":
	set(val):
		map_type = val
		for config in Data.maps[val]["spawner_settings"].keys():
			set(config, Data.maps[val]["spawner_settings"][config])

var difficulty := {}
var spawnable_enemies := []
var max_waves := 3
var special_waves := {}
var wave_spawn_count := 10

var current_wave_spawn_count := 0
var current_difficulty := 1.0
var current_wave := 0
var enemies_spawned_this_wave := 0
var killed_this_wave := 0

func spawn_new_enemy():
	var enemyScene := preload("res://Scenes/enemies/enemy_mover.tscn")
	var enemy = enemyScene.instantiate()
	enemy.enemy_type = spawnable_enemies.pick_random()
	add_child(enemy)
	enemies_spawned_this_wave += 1

func get_spawnable_enemies():
	var enemies := []
	for enemy in Data.enemies.keys():
		if current_difficulty >= Data.enemies[enemy]["difficulty"]:
			enemies.append(enemy)
	return enemies

func get_current_difficulty() -> float:
	var default_diff = difficulty["initial"]
	var increase = difficulty["increase"]
	var calculated_diff = default_diff * pow(increase, current_wave) if difficulty["multiplies"] else default_diff + increase * current_wave
	return calculated_diff

func _on_spawn_delay_timeout():
	if enemies_spawned_this_wave < current_wave_spawn_count:
		spawn_new_enemy()
		$SpawnDelay.start()

func _on_wave_delay_timer_timeout():
	#Move to next wave
	current_wave += 1
	killed_this_wave = 0
	enemies_spawned_this_wave = 0
	current_difficulty = get_current_difficulty()
	current_wave_spawn_count = round(wave_spawn_count * current_difficulty)
	spawnable_enemies = get_spawnable_enemies()
	Globals.waveStarted.emit(current_wave, current_wave_spawn_count)
	$SpawnDelay.start()

func enemy_destroyed():
	killed_this_wave += 1
	Globals.enemyDestroyed.emit(current_wave_spawn_count - killed_this_wave)
	check_wave_clear()
	
func check_wave_clear():
	if killed_this_wave == current_wave_spawn_count:
		#Wave cleared
		if not current_wave == max_waves:
			Globals.waveCleared.emit($WaveDelayTimer.wait_time)
			$WaveDelayTimer.start()
			return
		#game completion
		var mapCompletedScene := preload("res://Scenes/ui/mapCompleted/mapCompleted.tscn")
		var mapCompleted := mapCompletedScene.instantiate()
		Globals.hud.add_child(mapCompleted)
