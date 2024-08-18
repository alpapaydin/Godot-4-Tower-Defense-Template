extends Turret

func attack():
	if is_instance_valid(current_target):
		$AnimatedSprite2D.play("default")
		for a in $DetectionArea.get_overlapping_areas():
			var collider = a.get_parent()
			if collider.is_in_group("enemy"):
				collider.get_damage(damage)
	else:
		try_get_closest_target()
