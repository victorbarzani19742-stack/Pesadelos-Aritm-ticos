extends CharacterBody2D
class_name Aluno

@export_group("Locomotion")
@export var speed = 150.0
@export var jump_velocity = -300.0
@export var run_speed_damping = 5.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5

	var direction = Input.get_axis("left", "right")

	if direction:
		velocity.x = lerp(velocity.x, speed * direction, run_speed_damping * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)

	$Animation.trigger_animation(velocity, direction)
	move_and_slide()


func _on_zona_morta_body_entered(body):
	if body == self:
		die()


func die():
	GameOverUi.show_game_over()


func _go_to_menu():
	get_tree().change_scene_to_file("res://CENAS/menu.tscn")
