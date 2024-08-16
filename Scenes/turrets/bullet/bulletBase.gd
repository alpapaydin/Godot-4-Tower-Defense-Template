extends Node2D

var target = null
var speed: float = 400.0
var direction: Vector2

func _process(delta):
	if target:
		if not direction: 
			direction= (target - position).normalized()
		position += direction * speed * delta
