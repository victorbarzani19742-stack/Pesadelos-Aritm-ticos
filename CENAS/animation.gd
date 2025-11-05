extends AnimatedSprite2D

func trigger_animation(velocity: Vector2, direction: int):
	
	if direction != 0:
		scale.x = direction

	if not get_parent().is_on_floor():
		play("jump")
	elif sign(velocity.x) != sign(direction) && velocity.x != 0 && direction != 0:
		play("slide")
	elif velocity.x != 0:
		play("walk")
	else:
		play("aluno")
