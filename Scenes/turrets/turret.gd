extends Node2D

#Deploying
var deployed = false
var can_place = false
#Attacking
var current_target = null

func _process(_delta):
	if not deployed:
		if $CollisionArea.has_overlapping_areas():
			colliding()
		else:
			not_colliding()
	else:
		if current_target:
			look_at(current_target.position)

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
	if current_target:
		var projectileScene := preload("res://Scenes/turrets/bullet/bulletBase.tscn")
		var projectile := projectileScene.instantiate()
		Configs.projectilesNode.add_child(projectile)
		projectile.position = position
		projectile.target = current_target.position
