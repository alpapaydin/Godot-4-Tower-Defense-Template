extends Node2D

var target = null
var direction: Vector2

var speed: float = 400.0
var damage: float = 10
var pierce: int = 1

func _process(delta):
	if target:
		if not direction: 
			direction= (target - position).normalized()
		position += direction * speed * delta

func _on_area_2d_area_entered(area):
	var obj = area.get_parent()
	if obj.is_in_group("enemy"):
		pierce -= 1
		obj.get_damage(damage)
	if pierce == 0:
		queue_free()
