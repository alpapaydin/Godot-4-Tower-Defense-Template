extends Turret

var bulletSpeed := 200.0
var bulletPierce := 1

func attack():
	if is_instance_valid(current_target):
		var projectileScene := preload("res://Scenes/turrets/projectileTurret/bullet/bulletBase.tscn")
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
