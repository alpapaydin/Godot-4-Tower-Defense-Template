extends Node2D

#Deploying
var deployed = false
var can_place = false
#Attacking
var current_target = null
#Stats
var attack_speed := 1.0:
	set(value):
		attack_speed = value
		$AttackCooldown.wait_time = 1.0/value
		
var range_multiplier := 1.0:
	set(value):
		range_multiplier = value
		
var damage := 1.0
var bulletSpeed := 200.0
var bulletPierce := 1

func _process(_delta):
	if not deployed:
		if $CollisionArea.has_overlapping_areas():
			colliding()
		else:
			not_colliding()
	else:
		if is_instance_valid(current_target):
			look_at(current_target.position)
		else:
			try_get_closest_target()

func set_placeholder():
	modulate = Color("6eff297a")

func build():
	deployed = true
	modulate = Color.WHITE

func colliding():
	can_place = false
	modulate = Color("ff5c2990")

func not_colliding():
	can_place = true
	modulate = Color("6eff297a")

func _on_detection_area_area_entered(area):
	if deployed and not current_target:
		var area_parent = area.get_parent()
		if area_parent.is_in_group("enemy"):
			current_target = area.get_parent()

func _on_detection_area_area_exited(area):
	if deployed and current_target == area.get_parent():
		current_target = null
		try_get_closest_target()

func try_get_closest_target():
	var closest = 1000
	var closest_area = null
	for area in $DetectionArea.get_overlapping_areas():
		var dist = area.position.distance_to(position)
		if dist < closest:
			closest = dist
			closest_area = area
	if closest_area:
		current_target = closest_area.get_parent()

func attack():
	if is_instance_valid(current_target):
		attack_speed = 5
		var projectileScene := preload("res://Scenes/turrets/bullet/bulletBase.tscn")
		var projectile := projectileScene.instantiate()
		projectile.damage = damage
		projectile.speed = bulletSpeed
		projectile.pierce = bulletPierce
		Globals.projectilesNode.add_child(projectile)
		projectile.position = position
		projectile.target = current_target.position
