extends Path2D
class_name EnemyPath

var wave_count := 10
var spawned_enemies := 0
var active_enemies := 0:
	set(value):
		active_enemies = value
		check_next_wave()

func _ready():
	spawn_next_wave()

func check_next_wave():
	if active_enemies == 0 and not get_parent().gameOver:
		spawn_next_wave()

func spawn_new_enemy():
	var enemyScene := preload("res://Scenes/enemies/enemy_mover.tscn")
	var enemy = enemyScene.instantiate()
	add_child(enemy)
	active_enemies += 1

func spawn_next_wave():
	$SpawnDelay.start()

func _on_spawn_delay_timeout():
	if active_enemies < wave_count:
		spawn_new_enemy()
	else:
		$SpawnDelay.stop()
