extends Node2D

var turret_type := "":
	set(value):
		turret_type = value
		$Sprite2D.texture = load(Data.turrets[value]["sprite"])
		$Sprite2D.scale = Vector2(Data.turrets[value]["scale"],Data.turrets[value]["scale"])
		for stat in Data.turrets[value]["stats"].keys():
			set(stat, Data.turrets[value]["stats"][stat])

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
var rotates := true
var attack_range := 1.0
var damage := 1.0
var bulletSpeed := 200.0
var bulletPierce := 1

func _process(_delta):
	if not deployed:
		@warning_ignore("standalone_ternary")
		colliding() if $CollisionArea.has_overlapping_areas() else not_colliding()
	elif rotates:
		@warning_ignore("standalone_ternary")
		look_at(current_target.position) if is_instance_valid(current_target) else try_get_closest_target()

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
	if not deployed:
		return
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
		var projectileScene := preload("res://Scenes/turrets/bullet/bulletBase.tscn")
		var projectile := projectileScene.instantiate()
		projectile.bullet_type = Data.turrets[turret_type]["bullet"]
		projectile.damage = damage
		projectile.speed = bulletSpeed
		projectile.pierce = bulletPierce
		Globals.projectilesNode.add_child(projectile)
		projectile.position = position
		projectile.target = current_target.position
	else:
		try_get_closest_target()

func _on_collision_area_input_event(_viewport, _event, _shape_idx):
	if deployed and Input.is_action_just_pressed("LeftClick"):
		var turretDetailsScene := preload("res://Scenes/ui/turretUI/turret_details.tscn")
		var details := turretDetailsScene.instantiate()
		Globals.hud.add_child(details)
